import 'dart:async';
import 'dart:io';

import 'package:apparence_cli/src/commands/command_extension.dart';
import 'package:apparence_cli/src/commands/logger_extension.dart';
import 'package:apparence_cli/src/commands/models/ci.dart';
import 'package:apparence_cli/src/commands/models/setup_config.dart';
import 'package:apparence_cli/src/commands/setup_command.dart';
import 'package:apparence_cli/src/templates/codemagic_bundle.dart';
import 'package:apparence_cli/src/templates/gitlab_ci_bundle.dart';
import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:mason/mason.dart';

class CiBuilderCommand extends Command<int> {
  final GeneratorBuilder _generator;
  final Logger _logger;

  CiBuilderCommand({
    Logger? logger,
    GeneratorBuilder? generator,
  })  : _logger = logger ?? Logger(),
        _generator = generator ?? MasonGenerator.fromBundle {
    argParser.addOption(
      'provider',
      help: 'The ci/cd provider to add.',
      mandatory: true,
      aliases: ['p'],
    );
  }

  @override
  String get description => '''Add ci tempalte file to your project''';

  @override
  String get usage =>
      "$description\nusage example: dart run apparence_cli.dart ci --provider=codemagic .";

  @override
  String get name => "ci";

  @override
  FutureOr<int> run() async {
    final outputPath = _getOutputPath();
    var setupResult = SetupResult.load(outputPath);

    final ciProvider = parseProvider();
    switch (ciProvider) {
      case CIProviders.codemagic:
        String? androidPackage;
        String? emailNotificationAdress;
        String? appleStoreAppId;
        String? appleStoreBundleId;

        _logger.info(
          '''Before doing this command be sure to have a Google Play store app created 
          and an Apple store app created.
          Check our documentation for more information: https://apparencekit.dev/docs/
          ''',
        );
        androidPackage = _logger.prompt('What is your android package name?');
        emailNotificationAdress = _logger.prompt(
          'Enter an email address for notifications after build completion',
        );
        appleStoreAppId = _logger.prompt(
          'Enter your apple store app id (ex 6448682536)',
        );
        appleStoreBundleId = _logger.prompt(
          'Enter your apple store bundle id (ex com.example.app)',
        );
        final codemagicGenerator = await _generator(codemagicBundle);
        await codemagicGenerator.generate(
          DirectoryGeneratorTarget(_relativeDirectory("")),
          vars: {
            'sentry': setupResult.useSentry,
            'android_package': androidPackage,
            'email_notification_adress': emailNotificationAdress,
            'apple_store_app_id': appleStoreAppId,
            'apple_store_bundle_id': appleStoreBundleId,
          },
        );
        break;
      case CIProviders.gitlab:
        String? appName;
        bool? useAndroid;
        bool? useIOS;
        bool? firebaseDistribution;
        String? firebaseAndroidStagingAppid;
        String? firebaseIosStagingAppid;
        String? notifyEmails;

        _logger.info(
          '''Before doing this command be sure to have a Google Play store app created 
          and an Apple store app created.
          Check our documentation for more information: https://apparencekit.dev/docs/
          ''',
        );
        appName = _logger.prompt('What is your app name?');
        useAndroid = _logger.ask('Do you want to build for Android?');
        useIOS = _logger.ask('Do you want to build for iOS?');
        firebaseDistribution = _logger.ask(
          'Do you want to distribute your app with Firebase App Distribution? (Staging only)',
        );
        if (firebaseDistribution) {
          firebaseAndroidStagingAppid = _logger.prompt(
            'Enter your firebase android staging app id',
          );
          firebaseIosStagingAppid = _logger.prompt(
            'Enter your firebase ios staging app id',
          );
        }

        final gitlabGenerator = await _generator(gitlabCiBundle);
        await gitlabGenerator.generate(
          DirectoryGeneratorTarget(_relativeDirectory("")),
          vars: <String, dynamic>{
            'name': appName,
            'android': useAndroid,
            'ios': useIOS,
            'firebase_distribution': firebaseDistribution,
            'firebase_android_staging_appid': firebaseAndroidStagingAppid,
            'firebase_ios_staging_appid': firebaseIosStagingAppid,
            'notify_emails': notifyEmails,
          },
        );
        break;
      default:
        throw Exception('Ci provider not handled yet: $ciProvider');
    }

    _logger.success('✅ generated codemagic.yaml file');
    return ExitCode.success.code;
  }

  CIProviders parseProvider() {
    final providerArgs = _argResults['provider'] as String?;
    if (providerArgs == null || providerArgs.isEmpty) {
      throw UsageException(
        'No option specified for the auth provider.',
        usage,
      );
    }
    return ciProviderFrom(providerArgs)!;
  }

  ArgResults get _argResults => argResults!;

  Directory _relativeDirectory(String path) {
    final directory = Directory("${_getOutputPath()}/$path");
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }
    return directory;
  }

  String _getOutputPath() => getOutputPath(_argResults);
}
