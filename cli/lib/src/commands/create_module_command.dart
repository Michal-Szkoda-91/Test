import 'dart:async';
import 'dart:io';

import 'package:apparence_cli/src/commands/command_extension.dart';
import 'package:apparence_cli/src/commands/models/setup_config.dart';
import 'package:apparence_cli/src/commands/setup_command.dart';
import 'package:apparence_cli/src/process_runner.dart';
import 'package:apparence_cli/src/templates/module_template_bundle.dart';
import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:mason/mason.dart';

class CreateModuleBuilderCommand extends Command<int> {
  final GeneratorBuilder _generator;
  final Logger _logger;

  CreateModuleBuilderCommand({
    Logger? logger,
    GeneratorBuilder? generator,
  })  : _logger = logger ?? Logger(),
        _generator = generator ?? MasonGenerator.fromBundle {
    argParser.addOption(
      'name',
      help: 'The name of your module',
      mandatory: true,
      aliases: ['n'],
    );
    argParser.addOption(
      'api',
      help: 'Create an API file for this module',
      mandatory: true,
      aliases: ['api'],
    );
  }

  @override
  String get description => '''Create a new module in your project''';

  @override
  String get usage => '''
$description\nusage example: dart run apparence_cli module --name='mymodule' .
=======
- The path must be the root of your project.
- Add the --api=name option to create an API file for this module.
  ''';

  @override
  String get name => "module";

  @override
  FutureOr<int> run() async {
    final outputPath = _getOutputPath();
    final setupResult = SetupResult.load(outputPath);
    final name = _argResults['name'] as String;
    final apiFile = _argResults['api'] as String?;

    _logger.info('📦 Creating a module $name...');

    final moduleGenerator = await _generator(moduleTemplateBundle);
    await moduleGenerator.generate(
      DirectoryGeneratorTarget(_relativeDirectory("")),
      vars: {
        'name': name,
        'api_name': apiFile ?? '',
        'create_api': apiFile != null,
        'http_client': !setupResult.useFirebaseFirestore,
        'firestore': setupResult.useFirebaseFirestore,
      },
    );

    try {
      await BuildRunner().run();
    } catch (_) {}

    _logger.success(
      '✅ Module $name created in ${_getOutputPath()}/lib/modules/',
    );

    return ExitCode.success.code;
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
