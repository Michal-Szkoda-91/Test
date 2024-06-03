import 'dart:io';

import 'package:mason/mason.dart';

abstract class ProcessRunner {
  Future<ProcessResult> run();

  String? get infoMessage;

  Future<ProcessResult> runCmd(
    String cmd,
    List<String> args, {
    String? directory,
    bool runInShell = true,
  }) async {
    if (infoMessage != null) {
      Logger().info(infoMessage);
    }
    final result = await Process.run(
      cmd,
      args,
      workingDirectory: directory,
      runInShell: runInShell,
    );
    if (result.exitCode != 0) {
      final values = {
        'Standard out': result.stdout.toString().trim(),
        'Standard error': result.stderr.toString().trim(),
      }..removeWhere((k, v) => v.isEmpty);
      var message = values.isNotEmpty
          ? values.entries.map((e) => '${e.key}\n${e.value}').join('\n')
          : 'Unknown error';
      throw ProcessException(cmd, args, message, result.exitCode);
    }
    return result;
  }

  // ignore: unused_element
  Future<Process> _startCmd(
    String cmd,
    List<String> args, {
    String? directory,
    bool runInShell = true,
  }) async {
    if (infoMessage != null) {
      Logger().info(infoMessage);
    }
    final result = await Process.start(
      cmd,
      args,
      workingDirectory: directory,
      runInShell: runInShell,
    );
    if (await result.exitCode != 0) {
      final values = {
        'Standard out': result.stdout.toString().trim(),
        'Standard error': result.stderr.toString().trim(),
      }..removeWhere((k, v) => v.isEmpty);
      var message = values.isNotEmpty
          ? values.entries.map((e) => '${e.key}\n${e.value}').join('\n')
          : 'Unknown error';
      throw ProcessException(cmd, args, message);
    }
    return result;
  }
}

/// add a dependency to the pubspec
class AddDependencyCmdRunner extends ProcessRunner {
  final String dependency;

  AddDependencyCmdRunner(this.dependency);

  @override
  Future<ProcessResult> run() => runCmd('flutter', ['pub', 'add', dependency]);

  @override
  String? get infoMessage => '...adding $dependency';
}

/// add a dependency to the pubspec
class AddDevDependencyCmdRunner extends ProcessRunner {
  final String dependency;

  AddDevDependencyCmdRunner(this.dependency);

  @override
  Future<ProcessResult> run() =>
      runCmd('flutter', ['pub', 'add', '--dev', dependency]);

  @override
  String? get infoMessage => '...adding $dependency';
}

/// refresh project installation
class RefreshDependencyCmdRunner extends ProcessRunner {
  RefreshDependencyCmdRunner();

  @override
  Future<ProcessResult> run() => runCmd('flutter', ['pub', 'get']);

  @override
  String? get infoMessage => '...installing packages';
}

class RemoveDependencyCmdRunner extends ProcessRunner {
  final String dependency;

  RemoveDependencyCmdRunner(this.dependency);

  @override
  Future<ProcessResult> run() => runCmd(
        'flutter',
        ['pub', 'remove', dependency],
      );

  @override
  String? get infoMessage => '...removing $dependency if exists';
}

class FlutterCmdRunner extends ProcessRunner {
  final List<String> command;

  FlutterCmdRunner(this.command);

  @override
  Future<ProcessResult> run() => runCmd('flutter', command);

  @override
  String? get infoMessage => '...running flutter ${command.join(' ')}';
}

class BasicCmdRunner extends ProcessRunner {
  final String command;
  final List<String> args;

  BasicCmdRunner(this.command, this.args);

  @override
  Future<ProcessResult> run() => runCmd(command, args);

  @override
  String? get infoMessage => null;
}

class RefreshI18NCmdRunner extends ProcessRunner {
  RefreshI18NCmdRunner();

  @override
  Future<ProcessResult> run() => runCmd('dart', ['run', 'slang']);

  @override
  String? get infoMessage => '...refreshing i18n';
}

class BuildRunner extends ProcessRunner {
  BuildRunner();

  @override
  Future<ProcessResult> run() async {
    return runCmd(
      'dart',
      [
        'run',
        'build_runner',
        'build',
        '--delete-conflicting-outputs',
      ],
    );
  }

  @override
  String? get infoMessage => '...running build_runner';
}

class FirebaseCommandRunner extends ProcessRunner {
  final String projectId;
  final String fileSuffix;

  FirebaseCommandRunner({
    required this.projectId,
    required this.fileSuffix,
  });

  @override
  Future<ProcessResult> run() async {
    return runCmd('flutterfire', [
      'configure',
      '--project=$projectId',
      '--out',
      'lib/firebase_options_$fileSuffix.dart',
      '--platforms=android,ios',
      '--yes'
    ]);
  }

  @override
  String? get infoMessage => '...creating firebase configuration';
}

class CheckFirebaseCommandRunner extends ProcessRunner {
  CheckFirebaseCommandRunner();

  @override
  Future<ProcessResult> run() async {
    return runCmd('flutterfire', [
      '--version',
    ]);
  }

  @override
  String? get infoMessage => '...checking flutterfire tool version';
}

class DartFixRunner extends ProcessRunner {
  DartFixRunner();

  @override
  Future<ProcessResult> run() async {
    return runCmd(
      'dart',
      [
        'fix',
        '--apply',
      ],
    );
  }

  @override
  String? get infoMessage => '...running dart fix';
}

class PlUtilRunner extends ProcessRunner {
  final List<String> args;

  PlUtilRunner(this.args);

  @override
  Future<ProcessResult> run() async {
    return runCmd(
      'plutil',
      args,
    );
  }

  @override
  String? get infoMessage => '...running plUtil';
}

class GitPullRunner extends ProcessRunner {
  final String gitPath;
  final String directory;

  GitPullRunner(this.gitPath, {required this.directory});

  @override
  Future<ProcessResult> run() async {
    return runCmd(
      'git',
      [
        'clone',
        gitPath,
        directory,
      ],
    );
  }

  @override
  String? get infoMessage => '...clone git repo from $gitPath to $directory';
}

class FirebaseConfigGeneratorRunner extends ProcessRunner {
  final String? project;
  final String? output;

  FirebaseConfigGeneratorRunner({
    this.project,
    this.output,
  });

  @override
  String? get infoMessage => '...regenerating firebase config';

  @override
  Future<ProcessResult> run() {
    final args = ['configure'];
    if (project != null) {
      args.add('--project=$project');
    }
    if (output != null) {
      args.add('--out=$output');
    }
    args.add('--yes');
    return runCmd('flutterfire', args);
  }
}
