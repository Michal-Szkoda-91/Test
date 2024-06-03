// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationDataImpl _$$NotificationDataImplFromJson(Map json) =>
    _$NotificationDataImpl(
      id: json['id'] as String?,
      title: json['title'] as String,
      creationDate: DateTime.parse(json['creationDate'] as String),
      body: json['body'] as String,
      readDate: json['readDate'] == null
          ? null
          : DateTime.parse(json['readDate'] as String),
    );

Map<String, dynamic> _$$NotificationDataImplToJson(
        _$NotificationDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'creationDate': instance.creationDate.toIso8601String(),
      'body': instance.body,
      'readDate': instance.readDate?.toIso8601String(),
    };
