import 'dart:async';
import 'dart:io';

import 'package:apparence_cli/src/commands/command_extension.dart';
import 'package:apparence_cli/src/commands/models/backend.dart';
import 'package:apparence_cli/src/commands/models/setup_config.dart';
import 'package:apparence_cli/src/commands/setup_command.dart';
import 'package:apparence_cli/src/process_runner.dart';
import 'package:apparence_cli/src/templates/internationalization_bundle.dart';
import 'package:apparence_cli/src/templates/main_bundle.dart';
import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:mason/mason.dart';

class InternationalizationBuilderCommand extends Command<int> {
  final GeneratorBuilder _generator;
  final Logger _logger;
  final String? outputPath;

  InternationalizationBuilderCommand({
    Logger? logger,
    GeneratorBuilder? generator,
    this.outputPath,
  })  : _logger = logger ?? Logger(),
        _generator = generator ?? MasonGenerator.fromBundle;

  @override
  String get description => '''Add internationalization to your project''';

  @override
  String get usage =>
      "$description\nusage example: dart run apparence_cli.dart translations .";

  @override
  String get name => "translations";

  @override
  FutureOr<int> run() async {
    final outputPath = _getOutputPath();
    var setupResult = SetupResult.load(outputPath);
    _logger.info('🔥 Adding internationalization to your project...');

    await installDependencies(setupResult);
    final interGenerator = await _generator(internationalizationBundle);
    final mainGenerator = await _generator(mainBundle);
    // generate the i18n directory
    await interGenerator.generate(
      DirectoryGeneratorTarget(_relativeDirectory("")),
    );
    // regenerate main file with internationalization support
    await mainGenerator.generate(
      DirectoryGeneratorTarget(_relativeDirectory("lib")),
      vars: {
        'slang': true,
        'sentry': setupResult.useSentry,
        'supabase': setupResult.backendProvider == BackendProvider.supabase,
        'remoteConfig': setupResult.remoteConfigProvider != null,
      },
    );
    // run the slang generator
    await RefreshI18NCmdRunner().run();

    _logger.info('...writing apparenceKit setup result');
    setupResult = setupResult.copyWith(
      internationalization: true,
    );
    setupResult.write(_getOutputPath());
    _logger.success('✅ ApparenceKit internationalization setup complete');
    _logger.success('''
      ...
       - You can now use translation using the TranslationProvider like this : 'Translations.of(context).home.title'
       Please check our documentation for more details 
       https://github.com/Apparence-io/ApparenceKit-pro/blob/main/docs/internationalization.md
    ''');

    if (this.outputPath != null) {
      return 0;
    }
    return ExitCode.success.code;
  }

  Future<void> installDependencies(SetupResult config) async {
    List<ProcessRunner> processes = [];
    processes.add(AddDependencyCmdRunner('slang'));
    processes.add(AddDependencyCmdRunner('slang_flutter'));
    // For some reason Flutter intl version is not the last one
    processes.add(FlutterCmdRunner([
      'pub',
      'add',
      'override:intl:^0.19.0',
    ]));
    processes.add(FlutterCmdRunner([
      'pub',
      'add',
      'flutter_localizations',
      '--sdk=flutter',
    ]));

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
