import 'dart:async';
import 'dart:io';

import 'package:apparence_cli/src/commands/command_extension.dart';
import 'package:apparence_cli/src/commands/models/backend.dart';
import 'package:apparence_cli/src/commands/models/setup_config.dart';
import 'package:apparence_cli/src/commands/setup_command.dart';
import 'package:apparence_cli/src/process_runner.dart';
import 'package:apparence_cli/src/templates/main_bundle.dart';
import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:mason/mason.dart';

class SentryBuilderCommand extends Command<int> {
  final GeneratorBuilder _generator;
  final Logger _logger;
  final String? outputPath;

  SentryBuilderCommand({
    Logger? logger,
    GeneratorBuilder? generator,
    this.outputPath,
  })  : _logger = logger ?? Logger(),
        _generator = generator ?? MasonGenerator.fromBundle;

  @override
  String get description => '''Add Sentry to your project''';

  @override
  String get usage =>
      "$description\nusage example: dart pub global run apparence_cli sentry .";

  @override
  String get name => "sentry";

  @override
  FutureOr<int> run() async {
    final outputPath = _getOutputPath();
    var setupResult = SetupResult.load(outputPath);
    _logger.info('🔥 Adding sentry to your project...');

    await installDependencies(setupResult);
    final mainGenerator = await _generator(mainBundle);
    // regenerate main file with internationalization support
    await mainGenerator.generate(
      DirectoryGeneratorTarget(_relativeDirectory("lib")),
      vars: {
        'slang': setupResult.internationalization,
        'remoteConfig': setupResult.remoteConfigProvider != null,
        'analytics': setupResult.analyticsProvider != null,
        'supabase': setupResult.backendProvider == BackendProvider.supabase,
        'sentry': true,
      },
    );

    _logger.info('...writing apparenceKit setup result');
    setupResult = setupResult.copyWith(
      useSentry: true,
    );
    setupResult.write(_getOutputPath());
    _logger.success('✅ ApparenceKit sentry setup complete');
    _logger.success('''
      ... Check the error reporting doc for more infos. 
      All your errors will be automatically reported to Sentry.
      Don't forget to set your DSN in the SENTRY_DSN environment variable.
      https://github.com/Apparence-io/ApparenceKit-pro/blob/main/docs/errors.md
    ''');
    if (this.outputPath != null) {
      return 0;
    }
    return ExitCode.success.code;
  }

  Future<void> installDependencies(SetupResult config) async {
    List<ProcessRunner> processes = [];
    processes.add(AddDependencyCmdRunner('sentry_flutter'));
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
