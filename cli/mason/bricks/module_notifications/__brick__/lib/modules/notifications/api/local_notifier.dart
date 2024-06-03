import 'package:apparence_kit/core/initializer/onstart_service.dart';
import 'package:apparence_kit/modules/notifications/providers/models/notification.dart';
{{#webCompat}}import 'package:flutter/foundation.dart';{{/webCompat}}
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
{{#webCompat}}import 'package:universal_html/js.dart';{{/webCompat}}

final localNotifierProvider = Provider<LocalNotifier>((ref) {
  return LocalNotifier(
    notificationManager: FlutterLocalNotificationsPlugin(),
  );
});

final notificationsSettingsProvider = Provider<NotificationSettings>((ref) {
  return NotificationSettings(
    notificationManager: FlutterLocalNotificationsPlugin(),
    androidChannel: const AndroidNotificationChannel(
      // channel id - you can use different channels for different purposes (News, Messages, etc)
      'YourApp',
      // app id
      'YourApp',
      // this is the description of the channel that will be shown in the Android notification settings
      description: 'general YourApp channel',
      importance: Importance.max,
    ),
  );
});

/// Firebase shows automatically notifications when the app is in background
/// But when the app is in foreground, you have to show the notification yourself on iOS
/// Also with this you can schedule notifications
/// For more informations check the documentation: https://pub.dev/packages/flutter_local_notifications
///
/// As we don't rely on mocks we wrapped the flutter_local_notifications plugin for our needs
class LocalNotifier {
  final FlutterLocalNotificationsPlugin _notificationManager;

  LocalNotifier({
    required FlutterLocalNotificationsPlugin notificationManager,
  }) : _notificationManager = notificationManager;

  Future<void> show(NotificationSettings settings, Notification message) async {
    {{#webCompat}}
    if (kIsWeb) {
      context.callMethod("showNotification", [
        message.title,
        message.body,
      ]);
      return;
    }
    {{/webCompat}}
    _notificationManager.show(
      message.hashCode,
      message.title,
      message.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          settings.androidChannel.id,
          settings.androidChannel.name,
          importance: settings.androidChannel.importance,
          priority: Priority.high,
          channelDescription: settings.androidChannel.description ?? '',
        ),
      ),
      // you can add a payload to redirect the user to a specific page
      // payload: message.payload
    );
  }
}

/// This is the settings for the notifications
/// You could have this directly in LocalNotifier but it's better to separate the concerns
/// So now you can send different notifications with different settings
/// [init] method will be called automatically by the [Initializer] class
class NotificationSettings implements OnStartService {
  final FlutterLocalNotificationsPlugin _notificationManager;
  final AndroidNotificationChannel androidChannel;

  NotificationSettings({
    required FlutterLocalNotificationsPlugin notificationManager,
    required this.androidChannel,
  }) : _notificationManager = notificationManager;

  @override
  Future<void> init() async {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();
    const initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    _notificationManager.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) => redirectToPayload(payload),
    );
    await _notificationManager
        .resolvePlatformSpecificImplementation //
        <AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);
  }

  Future<void> redirectToPayload(
    NotificationResponse notificationResponse,
  ) async {
    // TODO uncomment this when you want to navigate to a specific page when the user clicks on the notification
    // final String? payload = notificationResponse.payload;
    // if (payload != null && payload.isNotEmpty) {
    //   navigatorKey.currentState?.pushNamed(payload);
    // }
  }
}
