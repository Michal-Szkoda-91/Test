import 'package:apparence_kit/modules/notifications/api/local_notifier.dart';
import 'package:apparence_kit/modules/notifications/providers/models/notification.dart';

class FakeLocalNotifierApi implements LocalNotifier {
  @override
  Future<void> show(NotificationSettings settings, Notification message) {
    return Future.value();
  }
}
