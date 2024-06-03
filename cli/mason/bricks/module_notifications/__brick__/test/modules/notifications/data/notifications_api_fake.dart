import 'package:apparence_kit/core/data/models/pageable.dart';
import 'package:apparence_kit/modules/notifications/api/entities/notifications_entity.dart';
import 'package:apparence_kit/modules/notifications/api/notifications_api.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FakeNotificationsApi implements NotificationsApi {
  OnRemoteMessage? _backgroundHandler;
  OnRemoteMessage? _foregroundHandler;
  OnRemoteMessage? _onOpenNotificationHandler;
  final List<String> _topics = [];

  @override
  Future<void> requestPermission() => Future.value();

  @override
  void setBackgroundHandler(OnRemoteMessage handler) {
    _backgroundHandler = handler;
  }

  @override
  void setForegroundHandler(OnRemoteMessage handler) {
    _foregroundHandler = handler;
  }

  @override
  void setOnOpenNotificationHandler(OnRemoteMessage handler) {
    _onOpenNotificationHandler = handler;
  }

  void sendBackgroundMessage(RemoteMessage message) {
    _backgroundHandler?.call(message);
  }

  void sendForegroundMessage(RemoteMessage message) {
    _foregroundHandler?.call(message);
  }

  void sendOnOpenNotificationMessage(RemoteMessage message) {
    _onOpenNotificationHandler?.call(message);
  }

  @override
  Future<Pageable<NotificationEntity>> get(
    String userId,
    int page,
    int pageSize,
  ) {
    return Future.value(
      Pageable(
        data: List.generate(
          20,
          (index) => NotificationEntity(
            id: '${page}_$index',
            title: 'title $index',
            body: 'body $index',
            creationDate: DateTime.now(),
            readDate: index > 2 ? DateTime.now() : null,
          ),
        ),
        page: page,
        pageSize: pageSize,
      ),
    );
  }

  @override
  Future<void> read(String userId, String notificationId) {
    return Future.value();
  }

  @override
  Stream<int> unreadNotifications(String userId) {
    return Stream.value(1);
  }

  @override
  void registerTopic(String topic) {
    _topics.add(topic);
  }

  @override
  void unregisterTopic(String topic) {
    _topics.remove(topic);
  }
}
