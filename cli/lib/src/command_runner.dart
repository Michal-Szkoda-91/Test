import 'package:apparence_cli/src/commands/analytics_command.dart';
import 'package:apparence_cli/src/commands/auth_command.dart';
import 'package:apparence_cli/src/commands/camera_command.dart';
import 'package:apparence_cli/src/commands/ci_command.dart';
import 'package:apparence_cli/src/commands/create_module_command.dart';
import 'package:apparence_cli/src/commands/internationalization_command.dart';
import 'package:apparence_cli/src/commands/onboarding_command.dart';
import 'package:apparence_cli/src/commands/remote_config_command.dart';
import 'package:apparence_cli/src/commands/sentry_command.dart';
import 'package:apparence_cli/src/commands/setup_command.dart';
import 'package:apparence_cli/src/commands/web_command.dart';
import 'package:args/command_runner.dart';
import 'package:mason/mason.dart';

/// A [CommandRunner] for the Apparence Flutter CLI
class ApparenceCommandRunner extends CommandRunner<int> {
  final Logger _logger;

  ApparenceCommandRunner({
    Logger? logger,
  })  : _logger = logger ?? Logger(),
        super(
          'ApparenceKit CLI',
          'Create an application without pain',
        ) {
    addCommand(SetupBuilderCommand(logger: logger));
    addCommand(AuthBuilderCommand(logger: logger));
    addCommand(WebCompatCommand(logger: logger));
    addCommand(InternationalizationBuilderCommand(logger: logger));
    addCommand(SentryBuilderCommand(logger: logger));
    addCommand(CiBuilderCommand(logger: logger));
    addCommand(OnboardingBuilderCommand(logger: logger));
    addCommand(CameraBuilderCommand(logger: logger));
    addCommand(RemoteConfigBuilderCommand(logger: logger));
    addCommand(AnalyticsCommand(logger: logger));
    addCommand(CreateModuleBuilderCommand(logger: logger));
  }

  @override
  Future<int> run(Iterable<String> args) async {
    try {
      final argResults = parse(args);
      return await runCommand(argResults) ?? ExitCode.success.code;
    } on FormatException catch (e, stackTrace) {
      _logger
        ..err(e.message)
        ..err('$stackTrace')
        ..info('')
        ..info(usage);
      return ExitCode.usage.code;
    } on UsageException catch (e) {
      _logger
        ..err(e.message)
        ..info('')
        ..info(usage);
      return ExitCode.usage.code;
    }
  }
}
