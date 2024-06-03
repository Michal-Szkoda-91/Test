import 'dart:async';
import 'dart:io';

import 'package:apparence_cli/src/commands/command_extension.dart';
import 'package:apparence_cli/src/commands/models/backend.dart';
import 'package:apparence_cli/src/commands/models/remote_config.dart';
import 'package:apparence_cli/src/commands/models/setup_config.dart';
import 'package:apparence_cli/src/commands/setup_command.dart';
import 'package:apparence_cli/src/process_runner.dart';
import 'package:apparence_cli/src/templates/main_bundle.dart';
import 'package:apparence_cli/src/templates/remote_config_bundle.dart';
import 'package:apparence_cli/src/templates/test_utils_bundle.dart';
import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:mason/mason.dart';

class RemoteConfigBuilderCommand extends Command<int> {
  final GeneratorBuilder _generator;
  final Logger _logger;
  final String? outputPath;

  RemoteConfigBuilderCommand({
    Logger? logger,
    GeneratorBuilder? generator,
    this.outputPath,
  })  : _logger = logger ?? Logger(),
        _generator = generator ?? MasonGenerator.fromBundle {
    argParser.addOption(
      'provider',
      help: 'The remote config provider to use (firebase only for now)',
      mandatory: true,
      aliases: ['p'],
    );
  }

  @override
  String get description => '''Add remote config to your project''';

  @override
  String get usage =>
      "$description\nusage example: dart run apparence_cli.dart remoteConfig .";

  @override
  String get name => "remoteConfig";

  @override
  FutureOr<int> run() async {
    final outputPath = _getOutputPath();
    var setupResult = SetupResult.load(outputPath);
    _logger.info('🤝 Adding remoteConfig to your project...');

    await installDependencies(setupResult);
    final mainGenerator = await _generator(mainBundle);
    final remoteConfigGenerator = await _generator(remoteConfigBundle);
    final testUtilsGenerator = await _generator(testUtilsBundle);
    // regenerate main file with internationalization support
    await mainGenerator.generate(
      DirectoryGeneratorTarget(_relativeDirectory("lib")),
      vars: {
        'slang': setupResult.internationalization,
        'sentry': setupResult.useSentry,
        'analytics': setupResult.analyticsProvider != null,
        'supabase': setupResult.backendProvider == BackendProvider.supabase,
        'remoteConfig': true,
      },
    );

    // generate remote config api
    await remoteConfigGenerator.generate(
      DirectoryGeneratorTarget(_relativeDirectory("")),
      vars: {
        'remoteConfig': true,
      },
    );

    // regenerate test utils with fake remote config api
    await testUtilsGenerator.generate(
      DirectoryGeneratorTarget(_relativeDirectory("test")),
      vars: {
        'analytics': setupResult.analyticsProvider != null,
        'remoteConfig': true,
      },
    );

    _logger.info('...writing apparenceKit setup result');
    setupResult = setupResult.copyWith(
      remoteConfigProvider: RemoteConfigProvider.firebase,
    );
    setupResult.write(_getOutputPath());
    _logger.success('✅ ApparenceKit remoteConfig setup complete');
    _logger.success(
        '''...Check the documentation for more information on how to use it:
    ''');
    if (this.outputPath != null) {
      return 0;
    }
    return ExitCode.success.code;
  }

  Future<void> installDependencies(SetupResult config) async {
    List<ProcessRunner> processes = [];
    processes.add(AddDependencyCmdRunner('firebase_remote_config'));
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
