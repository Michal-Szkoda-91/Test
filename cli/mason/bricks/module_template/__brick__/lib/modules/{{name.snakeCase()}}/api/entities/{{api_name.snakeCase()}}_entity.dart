{{#firestore}}
// ignore_for_file: invalid_annotation_target

import 'package:apparence_kit/core/data/entities/json_converters.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '{{api_name.snakeCase()}}_entity.freezed.dart';
part '{{api_name.snakeCase()}}_entity.g.dart';

@freezed
class {{api_name.pascalCase()}}Entity with _${{api_name.pascalCase()}}Entity {
  const factory {{api_name.pascalCase()}}Entity({
    @JsonKey(includeIfNull: false, toJson: Converters.id) String? id,
    required String name,
    @TimestampConverter() required DateTime creationDate,
  }) = {{api_name.pascalCase()}}EntityData;

  const {{api_name.pascalCase()}}Entity._();

  factory {{api_name.pascalCase()}}Entity.fromJson(String id, Map<String, dynamic> json) =>
      _${{api_name.pascalCase()}}FromJson(json..['id'] = id);
}

{{/firestore}}
{{#http_client}}
import 'package:freezed_annotation/freezed_annotation.dart';

part '{{api_name.snakeCase()}}_entity.freezed.dart';
part '{{api_name.snakeCase()}}_entity.g.dart';

@freezed
class {{api_name.pascalCase()}}Entity with _${{api_name.pascalCase()}}Entity {
  const factory {{api_name.pascalCase()}}Entity({
    // ignore: invalid_annotation_target
    @JsonKey(includeIfNull: false) String? id,
    required String name,
    required DateTime creationDate,
  }) = {{api_name.pascalCase()}}EntityData;

  const {{api_name.pascalCase()}}Entity._();

  factory {{api_name.pascalCase()}}Entity.fromJson(Map<String, dynamic> json) =>
      _${{api_name.pascalCase()}}EntityFromJson(json);
}

{{/http_client}}