// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserEntityDataImpl _$$UserEntityDataImplFromJson(Map json) =>
    _$UserEntityDataImpl(
      id: json['id'] as String?,
      creationDate: json['creation_date'] == null
          ? null
          : DateTime.parse(json['creation_date'] as String),
      lastUpdateDate: json['last_update_date'] == null
          ? null
          : DateTime.parse(json['last_update_date'] as String),
      email: json['email'] as String?,
      name: json['name'] as String,
      avatarPath: json['avatarPath'] as String?,
    );

Map<String, dynamic> _$$UserEntityDataImplToJson(
    _$UserEntityDataImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['creation_date'] = instance.creationDate?.toIso8601String();
  val['last_update_date'] = instance.lastUpdateDate?.toIso8601String();
  val['email'] = instance.email;
  val['name'] = instance.name;
  val['avatarPath'] = instance.avatarPath;
  return val;
}
