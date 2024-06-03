import 'package:apparence_cli/src/command_runner.dart';
import 'dart:io';

Future<void> main(List<String> args) async {
  await _flushThenExit(await ApparenceCommandRunner().run(args));
}

Future _flushThenExit(int status) {
  return Future.wait<void>([stdout.close(), stderr.close()])
      .then<void>((_) => exit(status));
}
