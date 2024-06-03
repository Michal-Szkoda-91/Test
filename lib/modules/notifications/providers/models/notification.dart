// ignore_for_file: invalid_annotation_target

import 'package:apparence_kit/modules/notifications/api/local_notifier.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification.freezed.dart';

@freezed
class Notification with _$Notification {
  const Notification._();

  const factory Notification.withData({
    String? id,
    String? title,
    String? body,
    required DateTime createdAt,
    DateTime? readAt,
    LocalNotifier? notifier,
    NotificationSettings? notifierSettings,
  }) = NotificationData;

  factory Notification.from(
    Map<String, dynamic> json, {
    String? id,
    LocalNotifier? notifierApi,
    NotificationSettings? notifierSettings,
  }) =>
      Notification.withData(
        id: id,
        title: json['title'] as String,
        body: json['body'] as String,
        createdAt: DateTime.now(),
        notifier: notifierApi,
        notifierSettings: notifierSettings,
      );

  Future<void> show({NotificationSettings? settings}) async {
    if (notifier == null) {
      throw Exception(
        'You must provide a LocalNotifierApi to show a notification',
      );
    }
    if (title == null || body == null) {
      // we don't show a notification without title or body
      // this is a silent notification that we want to handle
      // Improvement : we can create a sealed class with both types of notifications
      return;
    }
    if (notifierSettings != null) {
      await notifier!.show(notifierSettings!, this);
      return;
    } else if (settings != null) {
      await notifier!.show(settings, this);
      return;
    }
    throw Exception(
      'You must provide a NotificationSettings to show a notification',
    );
  }

  bool get seen => readAt != null;
}
