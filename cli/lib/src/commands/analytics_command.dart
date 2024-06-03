import 'dart:async';
import 'dart:io';

import 'package:apparence_cli/src/commands/command_extension.dart';
import 'package:apparence_cli/src/commands/models/backend.dart';
import 'package:apparence_cli/src/commands/models/setup_config.dart';
import 'package:apparence_cli/src/commands/setup_command.dart';
import 'package:apparence_cli/src/process_runner.dart';
import 'package:apparence_cli/src/templates/analytics_bundle.dart';
import 'package:apparence_cli/src/templates/main_bundle.dart';
import 'package:apparence_cli/src/templates/router_bundle.dart';
import 'package:apparence_cli/src/templates/test_utils_bundle.dart';
import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:mason/mason.dart';

class AnalyticsCommand extends Command<int> {
  final GeneratorBuilder _generator;
  final Logger _logger;
  final String? outputPath;
  final AnalyticsProviders? providerOverride;

  AnalyticsCommand({
    Logger? logger,
    GeneratorBuilder? generator,
    this.outputPath,
    this.providerOverride,
  })  : _logger = logger ?? Logger(),
        _generator = generator ?? MasonGenerator.fromBundle {
    argParser.addOption(
      'provider',
      help: 'the analytics provider (firebase, mixpanel)',
      mandatory: true,
      aliases: ['p'],
    );
  }

  @override
  String get description => ''' Add web compat to your project''';

  @override
  String get usage => '''
$description\nusage example: dart run apparence_cli.dart analytics --provider=mixpanel
      ''';

  @override
  String get name => "analytics";

  @override
  FutureOr<int> run() async {
    final outputPath = ".";
    var setupResult = SetupResult.load(outputPath);
    _logger.info('🔥 Adding analytics to your app...');
    await installDependencies(setupResult);

    final mainGenerator = await _generator(mainBundle);
    final routerGenerator = await _generator(routerBundle);
    final testUtilsGenerator = await _generator(testUtilsBundle);
    final analyticsGenerator = await _generator(analyticsBundle);

    await analyticsGenerator.generate(
      DirectoryGeneratorTarget(_relativeDirectory(".")),
      vars: {
        'mixpanel': analyticsProviderFromArgs == AnalyticsProviders.mixpanel,
        'firebase': analyticsProviderFromArgs == AnalyticsProviders.firebase,
      },
    );

    // regenerate main file with analytics support
    await mainGenerator.generate(
      DirectoryGeneratorTarget(_relativeDirectory("lib")),
      vars: {
        'slang': setupResult.internationalization,
        'sentry': setupResult.useSentry,
        'remoteConfig': setupResult.remoteConfigProvider != null,
        'supabase': setupResult.backendProvider == BackendProvider.supabase,
        'analytics': true,
      },
    );

    // regenerate router file with onboarding support
    await routerGenerator.generate(
      DirectoryGeneratorTarget(_relativeDirectory("lib")),
      vars: {
        'withOnboarding': setupResult.withOnboarding,
        'firebaseAnalytics':
            analyticsProviderFromArgs == AnalyticsProviders.firebase,
        'mixpanel': analyticsProviderFromArgs == AnalyticsProviders.mixpanel,
      },
    );

    // regenerate test utils with fake remote config api
    await testUtilsGenerator.generate(
      DirectoryGeneratorTarget(_relativeDirectory("test")),
      vars: {
        'remoteConfig': setupResult.remoteConfigProvider != null,
        'analytics': true,
      },
    );

    setupResult = setupResult.copyWith(
      analyticsProvider: analyticsProviderFromArgs,
    );
    setupResult.write(_getOutputPath());
    _logger.success('✅ Analytics added');
    _logger.info(
        "   Don't forget to add your analytics token in your environment file");
    _logger.info("   You can get it from https://mixpanel.com");
    if (this.outputPath != null) {
      return 0;
    }
    return ExitCode.success.code;
  }

  AnalyticsProviders get analyticsProviderFromArgs {
    if (providerOverride != null) {
      return providerOverride!;
    }
    final analyticsProvider = argResults?['provider'];
    return analyticsProviderFrom(analyticsProvider)!;
  }

  Future<void> installDependencies(SetupResult config) async {
    List<ProcessRunner> processes = [];
    final analyticsProvider = analyticsProviderFromArgs;
    switch (analyticsProvider) {
      case AnalyticsProviders.firebase:
        processes.add(AddDependencyCmdRunner('firebase_analytics'));
        break;
      case AnalyticsProviders.mixpanel:
        processes.add(AddDependencyCmdRunner('mixpanel_flutter'));
        break;
      default:
        throw ArgumentError.value(
          analyticsProvider,
          'provider',
          'provider must be firebase or mixpanel',
        );
    }
    processes.add(RefreshDependencyCmdRunner());
    for (var element in processes) {
      await element.run();
    }
  }

  ArgResults get _argResults => argResults!;

  // ignore: unused_element
  Directory _relativeDirectory(String path) {
    final directory = Directory("${_getOutputPath()}/$path");
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }
    return directory;
  }

  String _getOutputPath() {
    if (outputPath != null) {
      return outputPath!;
    }
    try {
      return getOutputPath(_argResults);
    } catch (_) {
      return ".";
    }
  }
}
