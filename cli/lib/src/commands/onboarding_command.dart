import 'dart:async';
import 'dart:io';

import 'package:apparence_cli/src/commands/command_extension.dart';
import 'package:apparence_cli/src/commands/models/setup_config.dart';
import 'package:apparence_cli/src/commands/setup_command.dart';
import 'package:apparence_cli/src/process_runner.dart';
import 'package:apparence_cli/src/templates/onboarding_bundle.dart';
import 'package:apparence_cli/src/templates/router_bundle.dart';
import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:mason/mason.dart';

class OnboardingBuilderCommand extends Command<int> {
  final GeneratorBuilder _generator;
  final Logger _logger;
  final String? outputPath;

  OnboardingBuilderCommand({
    Logger? logger,
    GeneratorBuilder? generator,
    this.outputPath,
  })  : _logger = logger ?? Logger(),
        _generator = generator ?? MasonGenerator.fromBundle;

  @override
  String get description => '''Add onboarding screens to your project''';

  @override
  String get usage =>
      "$description\nusage example: dart run apparence_cli.dart onboarding .";

  @override
  String get name => "onboarding";

  @override
  FutureOr<int> run() async {
    final outputPath = _getOutputPath();
    var setupResult = SetupResult.load(outputPath);
    _logger.info('👉 Adding generic onboarding screens to your app...');
    await installDependencies(setupResult);

    final routerGenerator = await _generator(routerBundle);
    final onboardingGenerator = await _generator(onboardingBundle);

    // regenerate router file with onboarding support
    await routerGenerator.generate(
      DirectoryGeneratorTarget(_relativeDirectory("lib")),
      vars: {
        'firebaseAnalytics':
            setupResult.analyticsProvider == AnalyticsProviders.firebase,
        'mixpanel':
            setupResult.analyticsProvider == AnalyticsProviders.mixpanel,
        'withOnboarding': true,
      },
    );

    // generate onboarding files
    await onboardingGenerator.generate(
      DirectoryGeneratorTarget(_relativeDirectory("lib")),
    );

    // add withOnboarding to setup result
    setupResult = setupResult.copyWith(withOnboarding: true);
    setupResult.write(_getOutputPath());
    _logger.success('✅ ApparenceKit onboarding setup complete');
    if (this.outputPath != null) {
      return 0;
    }
    return ExitCode.success.code;
  }

  Future<void> installDependencies(SetupResult config) async {
    List<ProcessRunner> processes = [];
    processes.add(AddDependencyCmdRunner('flutter_onboarding_slider'));
    processes.add(RefreshDependencyCmdRunner());
    for (var element in processes) {
      await element.run();
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
    if (outputPath != null) {
      return outputPath!;
    }
    return getOutputPath(_argResults);
  }
}
