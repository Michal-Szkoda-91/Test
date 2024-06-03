import 'package:apparence_kit/modules/notifications/api/local_notifier.dart';
import 'package:apparence_kit/modules/notifications/providers/models/notification.dart';
// ignore: depend_on_referenced_packages

class FakeLocalNotifier implements LocalNotifier {
  @override
  Future<void> show(NotificationSettings settings, Notification message) async {
    return;
  }
}
