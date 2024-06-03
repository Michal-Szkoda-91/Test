import 'dart:async';
import 'dart:io';

import 'package:apparence_cli/src/commands/command_extension.dart';
import 'package:apparence_cli/src/commands/logger_extension.dart';
import 'package:apparence_cli/src/commands/models/setup_config.dart';
import 'package:apparence_cli/src/commands/setup_command.dart';
import 'package:apparence_cli/src/process_runner.dart';
import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:mason/mason.dart';

enum AuthProvider {
  google,
  googlePlay,
  facebook,
  apple,
  twitter,
  microsoft,
  github,
  yahoo,
}

/// DEPRECATED
/// Remove this command in the next major version
/// Now auth cannot be setup without calling the setup command

class AuthBuilderCommand extends Command<int> {
  final GeneratorBuilder _generator;
  final Logger _logger;
  AuthProvider? authProvider;

  AuthBuilderCommand({
    Logger? logger,
    GeneratorBuilder? generator,
  })  : _logger = logger ?? Logger(),
        _generator = generator ?? MasonGenerator.fromBundle {
    argParser.addOption(
      'provider',
      help: 'The auth provider to use.',
      mandatory: true,
      aliases: ['p'],
    );
    argParser.addOption(
      'googleClientId',
      help: 'The Google Client ID to use.',
      mandatory: false,
      aliases: ['g'],
    );
  }

  @override
  String get description => ''' Add auth providers to your project''';

  @override
  String get usage => '''
$description\nusage example: dart run apparence_cli.dart auth --provider=google

Providers:  
  - google
  - google-play
  - facebook
  - apple
  - twitter
  - microsoft
  - github
  - yahoo
      ''';

  @override
  String get name => "auth";

  @override
  FutureOr<int> run() async {
    parseAuthProvider();
    final outputPath = ".";
    var setupResult = SetupResult.load(outputPath);

    await installDependencies(setupResult);

    if (setupResult.useFirebaseAuth) {
      _logger.info("🔥 Using Firebase Auth detected");
      final checkActivatedInConsole = _logger.ask(
          "Did you activate this auth provider in Firebase console? (y/n)");
      if (!checkActivatedInConsole) {
        _logger.info("--------------");
        _logger.info(
            "Please activate this auth provider in Firebase console and run this command again.");
        _logger.info(
          "👉 Go to firebase console > Authentication > Sign-in method > Activate $authProvider",
        );
        _logger.info(
          "For some providers you need some setup (ex: Facebook needs a Facebook app).",
        );
        _logger.info("--------------");
        return ExitCode.success.code;
      }

      // final firebaseAuthGenerator = FirebaseAuthGenerator.fromSetupFile(
      //   generator: _generator,
      //   outputPath: outputPath,
      //   setup: setupResult,
      //   authProvider: authProvider,
      // );
      // await firebaseAuthGenerator.run();
      final reloadFirebaseConfig = _logger.ask("Reload firebase config? (y/n)");
      if (reloadFirebaseConfig) {
        final projectId = _logger.prompt("Enter project id");
        final firebaseConfigGenerator = FirebaseConfigGeneratorRunner(
          output: 'lib/firebase_options_dev.dart',
          project: projectId,
        );
        try {
          await firebaseConfigGenerator.run();
        } catch (err) {
          // ignore error (flutterfire bug trying to edit some Xcode files...)
        }
        deleteFile(outputPath, "android/app/google-services.json");
        deleteFile(outputPath, "ios/Runner/GoogleService-Info.plist");
        _logger.info("✅ Firebase config reloaded");
      }
    } else {
      _logger.info("👌 Using standart backend detected");

      // await httpAuthGenerator.generate(
      //   DirectoryGeneratorTarget(
      //     _relativeDirectory("lib/modules/authentication/"),
      //   ),
      //   vars: <String, dynamic>{
      //     'googleSignIn': setupResult.useGoogleSignIn ||
      //         authProvider == AuthProvider.google,
      //     'googlePlaySignIn': setupResult.useGooglePlaySignIn ||
      //         authProvider == AuthProvider.googlePlay,
      //     'appleSignIn': setupResult.useAppleSignIn || //
      //         authProvider == AuthProvider.apple,
      //     'facebookSignIn': setupResult.useFacebookSignIn ||
      //         authProvider == AuthProvider.facebook,
      //     'addGoogleSigninDependency': setupResult.useGoogleSignIn ||
      //         setupResult.useGooglePlaySignIn ||
      //         authProvider == AuthProvider.google ||
      //         authProvider == AuthProvider.googlePlay,
      //   },
      // );
      _logger.info("--------------");
      _logger.info(
        "Social providers requires some setup (ex: Facebook needs a Facebook app).",
      );
      _logger.info(
          "please check the documentation in docs/social_auth.md for more details.");
      _logger.info("--------------");
    }
    _logger.info('✅...added social auth provider ${authProvider?.name}');
    setupResult = setupResult.withProvider(authProvider!);
    setupResult.write(outputPath);

    return ExitCode.success.code;
  }

  Future<void> installDependencies(SetupResult config) async {
    List<ProcessRunner> processes = [];
    switch (authProvider) {
      case AuthProvider.google:
        processes.add(AddDependencyCmdRunner('google_sign_in'));
        break;
      case AuthProvider.googlePlay:
        processes.add(AddDependencyCmdRunner('google_sign_in'));
        break;
      case AuthProvider.facebook:
        processes.add(AddDependencyCmdRunner('flutter_facebook_auth'));
        break;
      case AuthProvider.apple:
        // if firebase auth it's already installed
        if (!config.useFirebaseAuth) {
          processes.add(AddDependencyCmdRunner('sign_in_with_apple'));
        }
        break;
      // case AuthProvider.twitter:
      //   // TODO: Handle this case.
      //   break;
      // case AuthProvider.microsoft:
      //   // TODO: Handle this case.
      //   break;
      // case AuthProvider.github:
      //   // TODO: Handle this case.
      //   break;
      // case AuthProvider.yahoo:
      //   // TODO: Handle this case.
      //   break;
      case null:
        throw Exception("AuthProvider is null");
      default:
        throw Exception("This AuthProvider is not yet handled");
    }
    processes.add(RefreshDependencyCmdRunner());
    for (var element in processes) {
      await element.run();
    }
  }

  void parseAuthProvider() {
    final providerArgs = _argResults['provider'] as String?;
    if (providerArgs == null || providerArgs.isEmpty) {
      throw UsageException(
        'No option specified for the auth provider.',
        usage,
      );
    }
    switch (providerArgs) {
      case 'google':
        authProvider = AuthProvider.google;
        break;
      case 'googlePlay':
        authProvider = AuthProvider.googlePlay;
        break;
      case 'facebook':
        authProvider = AuthProvider.facebook;
        break;
      case 'apple':
        authProvider = AuthProvider.apple;
        break;
      case 'twitter':
        authProvider = AuthProvider.twitter;
        break;
      case 'microsoft':
        authProvider = AuthProvider.microsoft;
        break;
      case 'github':
        authProvider = AuthProvider.github;
        break;
      case 'yahoo':
        authProvider = AuthProvider.yahoo;
        break;
      default:
        throw UsageException('Unknown auth provider: $providerArgs', usage);
    }
  }

  ArgResults get _argResults => argResults!;

  Directory _relativeDirectory(String path) {
    final directory = Directory("${_getOutputPath()}/$path");
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }
    return directory;
  }

  String _getOutputPath() {
    try {
      return getOutputPath(_argResults);
    } catch (_) {
      return ".";
    }
  }
}
