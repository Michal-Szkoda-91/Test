// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'notifications_entity.freezed.dart';
part 'notifications_entity.g.dart';

@freezed
class NotificationEntity with _$NotificationEntity {
  const factory NotificationEntity({
    String? id,
    @JsonKey(name: 'user_id') String? userId,
    required String title,
    @JsonKey(name: 'creation_date') required DateTime creationDate,
    required String body,
    @JsonKey(name: 'read_date') DateTime? readDate,
    // NotificationTypes? type,
  }) = NotificationData;

  factory NotificationEntity.fromJson(Map<String, Object?> json) =>
      _$NotificationEntityFromJson(json);
}
