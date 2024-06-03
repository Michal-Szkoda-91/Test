import 'package:apparence_kit/core/data/api/base_api_exceptions.dart';
import 'package:apparence_kit/core/data/models/pageable.dart';
import 'package:apparence_kit/modules/notifications/api/entities/notifications_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final notificationsApiProvider = Provider<NotificationsApi>(
  (ref) => FirebaseNotificationsApi(
    messaging: FirebaseMessaging.instance,
    logger: Logger(),
    client: FirebaseFirestore.instance,
  ),
);

/// This class is responsible for listening from firebase notifications
/// As I like repositories to not depend on external libraries
/// I wrapped some of the firebase messaging methods
///
/// You could use directly the firebase messaging methods but making a fake implementation
/// of this class would be harder.
abstract class NotificationsApi {
  /// Request permission to receive notifications
  Future<void> requestPermission();

  // Used to listen to notifications when the app is in foreground
  void setForegroundHandler(OnRemoteMessage handler);
  // Used to listen to notifications when the app is in background
  void setBackgroundHandler(OnRemoteMessage handler);
  // Used to listen to notifications when user clicks on the notification
  void setOnOpenNotificationHandler(OnRemoteMessage handler);
  // Used to get the past notifications from the server
  Future<Pageable<NotificationEntity>> get(
      String userId, int page, int pageSize);
  // Used to mark a notification as read
  Future<void> read(String userId, String notificationId);
  // Used to get the unread notifications count
  Stream<int> unreadNotifications(String userId);

  // Used to register to a topic
  // (this allows you to send notifications to a group of users)
  // You can create one general topic for each language
  void registerTopic(String topic);

  // Used to unregister from a topic
  void unregisterTopic(String topic);
}

typedef OnRemoteMessage = Future<void> Function(RemoteMessage message);

class FirebaseNotificationsApi implements NotificationsApi {
  final FirebaseMessaging _messaging;
  final FirebaseFirestore _client;
  final Logger _logger;

  FirebaseNotificationsApi({
    required FirebaseMessaging messaging,
    required FirebaseFirestore client,
    required Logger logger,
  })  : _messaging = messaging,
        _client = client,
        _logger = logger;

  CollectionReference<NotificationEntity?> _collection(String userId) => _client
      .collection('users')
      .doc(userId)
      .collection('notifications')
      .withConverter(
        fromFirestore: (snapshot, _) {
          if (snapshot.exists) {
            return NotificationEntity.fromJson(snapshot.id, snapshot.data()!);
          }
          return null;
        },
        toFirestore: (data, _) => data!.toJson(),
      );

  @override
  Future<void> requestPermission() async {
    try {
      await _messaging.requestPermission();
    } catch (e) {
      _logger.e(e);
    }
  }

  @override
  void setForegroundHandler(OnRemoteMessage handler) {
    FirebaseMessaging.onMessage.listen(handler);
  }

  @override
  void setBackgroundHandler(OnRemoteMessage handler) {
    FirebaseMessaging.onBackgroundMessage(handler);
  }

  @override
  void setOnOpenNotificationHandler(OnRemoteMessage handler) {
    FirebaseMessaging.onMessageOpenedApp.listen(handler);
  }

  @override
  Future<Pageable<NotificationEntity>> get(
    String userId,
    int page,
    int pageSize,
  ) async {
    try {
      return _collection(userId) //
          .orderBy('creation_date', descending: true)
          .get()
          .then(
            (value) => Pageable(
              page: page,
              pageSize: pageSize,
              data: value.docs.map((e) => e.data()!).toList(),
            ),
          );
    } catch (e, stacktrace) {
      throw ApiError(
        code: 0,
        message: '$e: $stacktrace',
      );
    }
  }

  @override
  Future<void> read(String userId, String notificationId) async {
    try {
      await _collection(userId).doc(notificationId).update({
        'seen_date': DateTime.now(),
      });
    } catch (e, stacktrace) {
      throw ApiError(
        code: 0,
        message: '$e: $stacktrace',
      );
    }
  }

  @override
  Stream<int> unreadNotifications(String userId) {
    try {
      // prefer reading a counter from a document (like on your user or a stats subscollection)
      return _collection(userId)
          .where('seen_date', isNull: true)
          .snapshots()
          .map((event) => event.docs.length);
    } catch (e, stacktrace) {
      debugPrint('$e: $stacktrace');
      throw ApiError(
        code: 0,
        message: '$e: $stacktrace',
      );
    }
  }

  @override
  void registerTopic(String topic) {
    _messaging.subscribeToTopic(topic);
  }

  @override
  void unregisterTopic(String topic) {
    _messaging.unsubscribeFromTopic(topic);
  }
}
