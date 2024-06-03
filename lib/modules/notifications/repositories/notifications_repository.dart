import 'package:apparence_kit/core/data/models/pageable.dart';
import 'package:apparence_kit/core/initializer/onstart_service.dart';
import 'package:apparence_kit/core/states/notifications_dispatcher.dart';
import 'package:apparence_kit/modules/notifications/api/local_notifier.dart';
import 'package:apparence_kit/modules/notifications/api/notifications_api.dart';
import 'package:apparence_kit/modules/notifications/providers/models/notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart' show RemoteMessage;
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class NotificationsRepository implements OnStartService {
  // this method is used to get the notifications from the server
  Future<Pageable<Notification>> get(
    String userId, {
    int page = 0,
    int pageSize = 20,
  });

  // mark a notification as read
  Future<Notification> read(String userId, Notification notification);

  // listen to the unread notifications count
  Stream<int> listenToUnreadNotificationsCount(String userId);
}

final notificationRepositoryProvider = Provider<NotificationsRepository>(
  (ref) => AppNotificationsRepository(
    notificationsApi: ref.watch(notificationsApiProvider),
    notificationPublisher: ref.watch(notificationPublisherProvider),
    localNotifier: ref.watch(localNotifierProvider),
    notificationSettings: ref.watch(notificationsSettingsProvider),
  ),
);

class AppNotificationsRepository implements NotificationsRepository {
  final NotificationsApi _notificationsApi;
  final NotificationPublisher _notificationPublisher;
  final LocalNotifier _localNotifier;
  final NotificationSettings _notificationSettings;

  AppNotificationsRepository({
    required NotificationsApi notificationsApi,
    required NotificationPublisher notificationPublisher,
    required LocalNotifier localNotifier,
    required NotificationSettings notificationSettings,
  })  : _notificationsApi = notificationsApi,
        _localNotifier = localNotifier,
        _notificationSettings = notificationSettings,
        _notificationPublisher = notificationPublisher;

  @override
  Future<void> init() async {
    // this can be great to save if the user has granted permission
    // and to request permission him to go to settings if not
    await _notificationsApi.requestPermission();
    _notificationsApi.setForegroundHandler(_onMessage);
    // _notificationsApi.setBackgroundHandler(_onMessage);
    // _notificationsApi.setOnOpenNotificationHandler(_onMessage);
    // _notificationsApi.registerTopic('general');
  }

  Future<void> _onMessage(RemoteMessage message) async {
    if (message.notification == null) {
      return;
    }
    final notification = Notification.from(
      message.notification!.toMap(),
      notifierApi: _localNotifier,
      notifierSettings: _notificationSettings,
    );
    _notificationPublisher.publish(notification);
  }

  @override
  Future<Pageable<Notification>> get(
    String userId, {
    int page = 0,
    int pageSize = 20,
  }) async {
    final notificationEntities = await _notificationsApi.get(
      userId,
      page,
      pageSize,
    );
    final notifications = notificationEntities.data
        .map(
          (e) => Notification.withData(
            id: e.id,
            title: e.title,
            body: e.body,
            createdAt: e.creationDate,
            readAt: e.readDate,
            notifier: _localNotifier,
            notifierSettings: _notificationSettings,
          ),
        )
        .toList();
    return Pageable<Notification>(
      data: notifications,
      page: page,
      pageSize: notifications.length,
    );
  }

  @override
  Future<Notification> read(String userId, Notification notification) async {
    if (notification.id == null) {
      throw Exception('A notification without id cannot be read');
    }
    await _notificationsApi.read(userId, notification.id!);
    return notification.copyWith(readAt: DateTime.now());
  }

  @override
  Stream<int> listenToUnreadNotificationsCount(String userId) {
    return _notificationsApi.unreadNotifications(userId);
  }
}
