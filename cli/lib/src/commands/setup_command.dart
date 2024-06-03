import 'dart:async';
import 'dart:io';

import 'package:apparence_cli/src/commands/analytics_command.dart';
import 'package:apparence_cli/src/commands/command_extension.dart';
import 'package:apparence_cli/src/commands/generators/android_config_generator.dart';
import 'package:apparence_cli/src/commands/generators/auth_module_generator.dart';
import 'package:apparence_cli/src/commands/generators/core_module_generator.dart';
import 'package:apparence_cli/src/commands/generators/ios_config_generator.dart';
import 'package:apparence_cli/src/commands/generators/notifications_module_generator.dart';
import 'package:apparence_cli/src/commands/generators/subscriptions_module_generator.dart';
import 'package:apparence_cli/src/commands/internationalization_command.dart';
import 'package:apparence_cli/src/commands/models/backend.dart';
import 'package:apparence_cli/src/commands/models/setup_config.dart';
import 'package:apparence_cli/src/commands/models/storage.dart';
import 'package:apparence_cli/src/commands/onboarding_command.dart';
import 'package:apparence_cli/src/commands/remote_config_command.dart';
import 'package:apparence_cli/src/commands/sentry_command.dart';
import 'package:apparence_cli/src/commands/web_command.dart';
import 'package:apparence_cli/src/process_runner.dart';
import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:mason/mason.dart';

/// A method which returns a [Future<MasonGenerator>] given a [MasonBundle].
typedef GeneratorBuilder = Future<MasonGenerator> Function(MasonBundle);

class SetupBuilderCommand extends Command<int> {
  final GeneratorBuilder _generator;
  final Logger _logger;
  StorageProviders? storageProvider;
  bool? allowAnonymousSignup;

  SetupBuilderCommand({
    Logger? logger,
    GeneratorBuilder? generator,
  })  : _logger = logger ?? Logger(),
        _generator = generator ?? MasonGenerator.fromBundle {
    argParser.addOption(
      'backendType',
      help: 'install sentry error reporting plugin',
      mandatory: false,
      aliases: ['b'],
    );
    argParser.addOption(
      'exampleFirebaseConf',
      help: 'only for internal use',
      mandatory: false,
      defaultsTo: 'false',
      aliases: ['t'],
    );
    argParser.addFlag(
      'anonymousAuth',
      help:
          'allows to automatically create an anonymous user at startup to let the user use the app without authentication',
      aliases: ['a'],
      defaultsTo: false,
    );
  }

  @override
  String get description => '''Setup a new project with ApparenceKit
  - choose using Firebase Auth and Firestore or Custom backend
  ''';

  @override
  String get usage =>
      "$description\nusage example: dart run apparence_cli.dart project .";

  @override
  String get name => "setup";

  @override
  FutureOr<int> run() async {
    // throw directly if the output directory has not been specified
    final outputPath = _getOutputPath();
    var setupResult = SetupResult.load(outputPath);
    final useExampleFirebaseConf =
        (_argResults['exampleFirebaseConf'] as String?) == 'true';

    // check if flutterfire cli is installed (skip on CI)
    try {
      await checkUsingLastFlutterVersion(_logger);
    } catch (err) {
      _logger.err(
        '👋 Flutter SDK seems not installed, please install it first',
      );
      return ExitCode.software.code;
    }
    final flutterFireInstalled = await checkFlutterFireInstalled();
    if (!useExampleFirebaseConf && !flutterFireInstalled) {
      return ExitCode.software.code;
    }

    var appName = 'ApparenceKit';
    if (!useExampleFirebaseConf) {
      appName = _logger.prompt(
        '👉  Enter the name of your app?',
        defaultValue: 'ApparenceKit',
      );
    }

    var bundleId = 'com.test';
    if (!useExampleFirebaseConf) {
      bundleId = _logger.prompt(
        '👉  Enter the bundle id of your app? (ex: io.apparence)',
        defaultValue: 'io.apparence',
      );
    }

    final backendTypeArg = _argResults['backendType'] as String?;
    BackendProvider? backendType = BackendProvider.fromString(backendTypeArg);
    if (backendTypeArg == null) {
      backendType = _logger.chooseOne(
        'Which backend do you want to use?',
        choices: BackendProvider.values,
        display: (e) => e?.name ?? '',
      );
    }

    switch (backendType) {
      case BackendProvider.firebase:
        allowAnonymousSignup = _logger.confirm(
          'Would you like to automatically signup user anonymously?',
        );
        _logger.detail(
          "(This allows a user to access your app without any login. You will be able to link his account to an email or any other login later)",
        );
        final useFirebaseStorage = _logger.confirm(
          'Do you want to use Firebase Storage?',
        );
        if (useFirebaseStorage) {
          storageProvider = StorageProviders.firebase;
        }
        break;
      case BackendProvider.supabase:
        final useSupabaseStorage = _logger.confirm(
          'Do you want to use Supabase Storage?',
        );
        if (useSupabaseStorage) {
          storageProvider = StorageProviders.supabase;
        }
        break;
      case BackendProvider.restApi:
        break;
      case null:
        break;
    }

    // ask user requirements for the project
    final useSentry = _logger.confirm(
      'Do you want to use Sentry error reporting plugin?',
    );
    final useFirebaseConfig = _logger.confirm(
      'Do you want to use Firebase Remote Config?',
    );
    final webCompat = _logger.confirm(
      'Do you want to add web platform?',
    );
    final analytics = _logger.confirm(
      'Do you want to add analytics (Mixpanel)?',
    );
    final onboarding = _logger.confirm(
      'Do you want to add generic onboarding screens?',
    );
    final internationalization = _logger.confirm(
      'Do you want to add internationalization support?',
    );

    setupResult = setupResult.copyWith(
      backendProvider: backendType,
      useFirebaseAuth: BackendProvider.firebase == backendType,
      useFirebaseFirestore: BackendProvider.firebase == backendType,
      storageProvider: storageProvider,
      appName: appName,
      bundleId: bundleId,
      anonymousSignup: allowAnonymousSignup ?? //
          _argResults['anonymousAuth'] as bool,
      internationalization: internationalization,
      useSentry: useSentry,
    );

    // create flutter project using flutter create
    await createFlutterProject();

    // update android bundleId
    await AndroidConfigGenerator(
      generator: _generator,
      outputPath: _getOutputPath(),
      setupResult: setupResult,
    ).run();
    // update ios bundleId
    await IosConfigGenerator(
      generator: _generator,
      outputPath: _getOutputPath(),
      setupResult: setupResult,
    ).run();

    // create firebase configuration file if possible
    await createFirebaseConf(useExampleFirebaseConf);

    // generate apparenceKit modules
    await CoreModuleGenerator(
      generator: _generator,
      outputPath: _getOutputPath(),
      setupResult: setupResult,
    ).run();
    await AuthModuleGenerator(
      generator: _generator,
      outputPath: _getOutputPath(),
      setupResult: setupResult,
    ).run();
    await SubscriptionsModuleGenerator(
      generator: _generator,
      outputPath: _getOutputPath(),
      setupResult: setupResult,
    ).run();
    await NotificationsModuleGenerator(
      generator: _generator,
      outputPath: _getOutputPath(),
      setupResult: setupResult,
    ).run();

    _logger.info('...writing apparenceKit setup result');
    setupResult.write(_getOutputPath());

    if (useSentry) {
      final sentryCmd = SentryBuilderCommand(
        logger: _logger,
        outputPath: outputPath,
      );
      await sentryCmd.run();
    }

    if (useFirebaseConfig) {
      final remoteConfigCmd = RemoteConfigBuilderCommand(
        logger: _logger,
        outputPath: outputPath,
      );
      await remoteConfigCmd.run();
    }

    if (webCompat) {
      final webCompatCmd = WebCompatCommand(
        logger: _logger,
        outputPath: outputPath,
      );
      await webCompatCmd.run();
    }

    if (onboarding) {
      final onboardingCmd = OnboardingBuilderCommand(
        logger: _logger,
        outputPath: outputPath,
      );
      await onboardingCmd.run();
    }

    if (analytics) {
      final analyticsCmd = AnalyticsCommand(
        logger: _logger,
        outputPath: outputPath,
        providerOverride: AnalyticsProviders.mixpanel,
      );
      await analyticsCmd.run();
    }

    if (internationalization) {
      final internationalizationCmd = InternationalizationBuilderCommand(
        logger: _logger,
        outputPath: outputPath,
      );
      await internationalizationCmd.run();
    }

    await Future.delayed(Duration(seconds: 1));
    try {
      await BuildRunner().run();
      // await DartFixRunner().run();
    } catch (_) {} // build runner returns somes warning as errors...

    // pull firebase or supabase functions boilerplate
    if (!useExampleFirebaseConf) {
      await pullFunctionsBoilerplate(setupResult);
    }

    _logger.success('✅ ApparenceKit setup completed');
    return ExitCode.success.code;
  }

  Future<void> pullFunctionsBoilerplate(SetupResult setupResult) async {
    const firebaseRepoUrl =
        "https://github.com/Apparence-io/ApparenceKit-firebase";
    const supabaseRepoUrl =
        "https://github.com/Apparence-io/ApparenceKit-supabase";
    String? repositoryUrl;
    switch (setupResult.backendProvider) {
      case BackendProvider.firebase:
        repositoryUrl = firebaseRepoUrl;
        break;
      case BackendProvider.supabase:
        repositoryUrl = supabaseRepoUrl;
        break;
      case BackendProvider.restApi:
        break;
    }
    if (repositoryUrl == null) {
      return;
    }
    try {
      await GitPullRunner(
        repositoryUrl,
        directory: 'backend',
      ).run();
      _logger.info(
        '✅ ${setupResult.backendProvider.name} functions boilerplate pulled successfully in the /backend directory',
      );
    } catch (_) {
      _logger.warn(
        'ℹ️ Failed to clone functions template.',
      );
      _logger.warn('Check you have access to the repository then run');
      _logger.warn(
        '(An invitation has been sent to your github account after purchasing ApparenceKit)',
      );
      _logger.warn('git clone $firebaseRepoUrl');
    }
  }

  /// returns true if the flutterFire CLI is installed
  Future<bool> checkFlutterFireInstalled() async {
    try {
      await CheckFirebaseCommandRunner().run();
      return true;
    } catch (e) {
      _logger.err(
        '👋 FlutterFire CLI is not installed, please run `dart pub global activate flutterfire_cli` first',
      );
      return false;
    }
  }

  Future<void> createFlutterProject() async {
    // flutter create --platforms=ios,android . --project-name=apparence_kit
    // Don't ask bundleId for now as it's also adding the project-name to the bundleId
    // (And we cannot change the package name from the apparence_kit template)
    final bundleid = 'io.apparence';

    // final bundleid =
    //     _logger.prompt('👉 Enter a bundle id (ex: io.apparence.apparencekit)');
    await FlutterCmdRunner([
      'create',
      '--platforms=ios,android',
      _getOutputPath(),
      '--project-name=apparence_kit',
      '--org',
      bundleid
    ]).run();
  }

  /// Creates firebase configuration file
  Future<void> createFirebaseConf(bool useExampleConf) async {
    if (useExampleConf) {
      await addExampleFirebaseConf();
      return;
    }
    try {
      final firebaseProjectId = _logger.prompt(
        '👉 Enter your Firebase project id? (leave blank to skip)',
      );
      if (firebaseProjectId.isEmpty) {
        throw Exception('Firebase project id is required');
      }
      await FirebaseCommandRunner(
        projectId: firebaseProjectId,
        fileSuffix: 'dev',
      ).run();
    } catch (e) {
      _logger.warn(
        'Please run flutterfire configure --project=<YOU-PROJECT-ID> --out lib/firebase_options_dev.dart manually if lib/firebase_options_dev.dart is not created',
      );
    }
  }

  /// Add firebase configuration to the project
  /// Only for internal use (tests)
  Future<void> addExampleFirebaseConf() async {
    final exampleFirebaseConf = '''
// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB8BSpecCUrsIDwqKBXvnGASKdCX5i2VUA',
    appId: '1:577021276375:web:48e1d02a62dbdae5040092',
    messagingSenderId: '577021276375',
    projectId: 'apparencekit-pro',
    authDomain: 'apparencekit-pro.firebaseapp.com',
    storageBucket: 'apparencekit-pro.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDmxGCB6Nc5zdRsFxhS04cNucf1_M6XAYY',
    appId: '1:577021276375:android:9442aaa5b7695c96040092',
    messagingSenderId: '577021276375',
    projectId: 'apparencekit-pro',
    storageBucket: 'apparencekit-pro.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD6A_37XHqfpbkrztZLtvpqTMiEdrwEVZk',
    appId: '1:577021276375:ios:10185c51353ffa66040092',
    messagingSenderId: '577021276375',
    projectId: 'apparencekit-pro',
    storageBucket: 'apparencekit-pro.appspot.com',
    iosClientId:
        '577021276375-88rdhg8hdjg9epjgn2ijvjbaruedqc8m.apps.googleusercontent.com',
    iosBundleId: 'com.example.apparenceKit',
  );
}
''';

    final outputPath = _getOutputPath();
    final firebaseConf = File('$outputPath/lib/firebase_options_dev.dart');
    await firebaseConf.writeAsString(exampleFirebaseConf);
  }

  // ignore: unused_element
  Directory get _outputDirectory => Directory(_getOutputPath());

  Directory _relativeDirectory(String path) {
    final directory = Directory("${_getOutputPath()}/$path");
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }
    return directory;
  }

  String _getOutputPath() => getOutputPath(_argResults);

  ArgResults get _argResults => argResults!;
}
