import 'dart:io';

import 'package:apparence_cli/src/process_runner.dart';
import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:mason/mason.dart';

extension DeleteFile on Command {
  void deleteFile(String basePath, String path) {
    final file = File("$basePath/$path");
    if (file.existsSync()) {
      file.deleteSync();
    }
  }
}

extension GetOutputPath on Command {
  String getOutputPath(ArgResults argResults) {
    final args = argResults.rest;
    if (args.isEmpty) {
      throw UsageException(
        'No option specified for the output directory.',
        usage,
      );
    }
    if (args.length > 1) {
      throw UsageException('Multiple output directories specified.', usage);
    }
    return args.first;
  }
}

extension DependencieCommands on Command {
  void handleDependency(bool include, String dependency) {
    if (include) {
      AddDependencyCmdRunner(dependency).run();
    } else {
      RemoveDependencyCmdRunner(dependency).run();
    }
  }
}

final _kminFlutterSdkVersion = Version.parse('3.16.7');

extension FlutterVersionChecker on Command {
  Future<void> checkUsingLastFlutterVersion(Logger logger) async {
    final flutterCommand = FlutterCmdRunner(['--version']);
    final result = await flutterCommand.run();
    // final result = await runCmd('flutter', ['--version']);
    final versionLine = result.stdout.split('\n')[0];
    final version = versionLine.split(' ')[1];

    final userVersion = Version.parse(version);

    if (userVersion < _kminFlutterSdkVersion) {
      logger.warn(
        'You are using Flutter SDK version $version, but this project requires Flutter SDK version $_kminFlutterSdkVersion',
      );
      logger.warn(
        'Please update your Flutter SDK, then run this command again.',
      );
      exit(1);
    } else {
      logger.info('Your Flutter SDK version is up to date ($version)');
    }
  }
}
