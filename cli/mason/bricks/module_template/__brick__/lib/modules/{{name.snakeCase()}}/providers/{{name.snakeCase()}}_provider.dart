import 'package:apparence_kit/modules/{{name.snakeCase()}}/providers/models/{{name.snakeCase()}}_page_state.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '{{name.snakeCase()}}_provider.g.dart';

@riverpod 
class {{name.pascalCase()}}Notifier extends _${{name.pascalCase()}}Notifier {
  final logger = Logger();

  @override
  Future<{{name.pascalCase()}}PageState> build() async {
    return {{name.pascalCase()}}PageState();
  }
}
