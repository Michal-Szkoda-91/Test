import 'dart:async';
import 'dart:io';

import 'package:apparence_cli/src/commands/command_extension.dart';
import 'package:apparence_cli/src/commands/generators/notifications_module_generator.dart';
import 'package:apparence_cli/src/commands/models/setup_config.dart';
import 'package:apparence_cli/src/commands/setup_command.dart';
import 'package:apparence_cli/src/process_runner.dart';
import 'package:apparence_cli/src/templates/web_compat_bundle.dart';
import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:mason/mason.dart';

class WebCompatCommand extends Command<int> {
  final GeneratorBuilder _generator;
  final Logger _logger;
  final String? outputPath;

  WebCompatCommand({
    Logger? logger,
    GeneratorBuilder? generator,
    this.outputPath,
  })  : _logger = logger ?? Logger(),
        _generator = generator ?? MasonGenerator.fromBundle {
    argParser.addOption(
      'name',
      help:
          'The web project name (apparencekit_pro is a valid name apparencekit-pro not).',
      mandatory: true,
      aliases: ['n'],
    );
  }

  @override
  String get description => ''' Add web compat to your project''';

  @override
  String get usage => '''
$description\nusage example: dart run apparence_cli.dart web --name=apparencekit_pro
      ''';

  @override
  String get name => "web";

  @override
  FutureOr<int> run() async {
    final outputPath = ".";
    var setupResult = SetupResult.load(outputPath);
    _logger.info('🔥 Adding web compat to your project...');
    await installDependencies(setupResult);
    setupResult = setupResult.copyWith(webCompat: true);

    final webCompatGenerator = await _generator(webCompatBundle);
    await webCompatGenerator.generate(
      DirectoryGeneratorTarget(_relativeDirectory(".")),
      vars: {
        'name': argResults?['name'] as String? ?? 'apparencekit_pro',
      },
    );
    await NotificationsModuleGenerator(
      generator: _generator,
      outputPath: _getOutputPath(),
      setupResult: setupResult,
      skipInstall: true,
    ).run();
    deleteFile('test', 'widget_test.dart');
    _logger.info('✅...added web compat to your project');

    setupResult.write(outputPath);

    if (this.outputPath != null) {
      return 0;
    }
    return ExitCode.success.code;
  }

  Future<void> installDependencies(SetupResult config) async {
    List<ProcessRunner> processes = [];
    processes.add(AddDependencyCmdRunner('universal_html'));
    processes.add(AddWebPlatformCmdRunner(name));
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
    try {
      return getOutputPath(_argResults);
    } catch (_) {
      return ".";
    }
  }
}

class AddWebPlatformCmdRunner extends ProcessRunner {
  final String name;

  AddWebPlatformCmdRunner(this.name);

  @override
  Future<ProcessResult> run() => runCmd('flutter',
      ['create', '--platforms=web', '.', '--project-name=apparencekit_pro']);

  @override
  String? get infoMessage => '...adding web platform with name $name';
}
