import 'package:apparence_kit/modules/{{name.snakeCase()}}/api/{{api_name.snakeCase()}}_api.dart';
//import 'package:apparence_kit/modules/{{name.snakeCase()}}/api/entities/{{api_name.snakeCase()}}_entity.dart';
import 'package:apparence_kit/modules/{{name.snakeCase()}}/domain/{{api_name.snakeCase()}}.dart';

final {{api_name.camelCase()}}RepositoryProvider = Provider<{{api_name.pascalCase()}}Repository>((ref) {
  return InboxRepository(
    api: ref.read({{api_name.camelCase()}}ApiProvider),
  );
});

class {{api_name.pascalCase()}}Repository {
  final {{api_name.pascalCase()}}Api _{{api_name.camelCase()}}Api;

  {{api_name.pascalCase()}}Repository({
    required {{api_name.pascalCase()}}Api api,
  }) : _{{api_name.camelCase()}}Api = api;

  Future<{{api_name.pascalCase()}}?> getFromId(String id) async {
    final entity = await _{{api_name.camelCase()}}Api.get(id);
    if(entity == null) {
      return null;
    }
    return {{api_name.pascalCase()}}.fromEntity(entity);
  }

}