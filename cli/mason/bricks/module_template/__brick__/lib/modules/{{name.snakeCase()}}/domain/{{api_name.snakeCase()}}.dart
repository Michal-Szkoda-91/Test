import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:apparence_kit/modules/{{name.snakeCase()}}/api/entities/{{api_name.snakeCase()}}_entity.dart';

part '{{api_name.snakeCase()}}.freezed.dart';

@freezed
sealed class {{api_name.pascalCase()}} with _${{api_name.pascalCase()}} {
  const factory {{api_name.pascalCase()}}({
    String? property,
  }) = {{api_name.pascalCase()}}Data;

  const {{api_name.pascalCase()}}._();

  factory {{api_name.pascalCase()}}.fromEntity({{api_name.pascalCase()}}Entity entity) => {{api_name.pascalCase()}}(
    property: entity.name,
  );

  // TODO implement this
  {{api_name.pascalCase()}}Entity toEntity() => throw UnimplementedError();
}