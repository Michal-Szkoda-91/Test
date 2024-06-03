import 'dart:io';

import 'package:apparence_cli/src/commands/models/backend.dart';
import 'package:apparence_cli/src/commands/models/setup_config.dart';
import 'package:apparence_cli/src/commands/setup_command.dart';
import 'package:apparence_cli/src/process_runner.dart';
import 'package:mason/mason.dart';

abstract class BaseModuleGenerator {
  final GeneratorBuilder generator;
  final Logger logger;
  final String outputPath;
  final SetupResult setupResult;

  BaseModuleGenerator({
    required this.generator,
    required this.outputPath,
    required this.setupResult,
  }) : logger = Logger();

  Future<void> run();

  Directory relativeDirectory(String path) {
    final directory = Directory("$outputPath/$path");
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }
    return directory;
  }

  Future<void> installDependencies(List<String> dependencies) async {
    List<ProcessRunner> processes = [];
    final commands = dependencies.map((e) => AddDependencyCmdRunner(e));
    processes.addAll(commands);
    for (var element in processes) {
      await element.run();
    }
  }

  Future<void> installDevDependencies(List<String> dependencies) async {
    List<ProcessRunner> processes = [];
    final commands = dependencies.map((e) => AddDevDependencyCmdRunner(e));
    processes.addAll(commands);
    for (var element in processes) {
      await element.run();
    }
  }

  Future<void> renameProviderApi(String apiPath, String fileName) async {
    for (final backendProvider in BackendProvider.values) {
      final path = '$apiPath/${backendProvider.name}_$fileName';
      final file = File(path);
      if (backendProvider == setupResult.backendProvider) {
        file.renameSync('$apiPath/$fileName');
      } else {
        if (file.existsSync()) {
          file.deleteSync();
        }
      }
    }
  }

  Future<void> refreshDependencies() async {
    final process = RefreshDependencyCmdRunner();
    await process.run();
  }
}
