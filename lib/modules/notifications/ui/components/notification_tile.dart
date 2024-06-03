import 'package:apparence_kit/modules/notifications/providers/models/notification.dart'
    as app;
import 'package:apparence_kit/modules/notifications/ui/widgets/notification_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class NotificationTileComponent extends StatelessWidget {
  final app.Notification notification;
  final int index;

  const NotificationTileComponent({
    super.key,
    required this.notification,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: const [
        FadeEffect(
          duration: Duration(milliseconds: 200),
        ),
        ScaleEffect(
          duration: Duration(milliseconds: 200),
          begin: Offset(1.2, 1.2),
        ),
        MoveEffect(
          duration: Duration(milliseconds: 150),
          begin: Offset(0, -50),
        ),
      ],
      delay: index < 6 ? Duration(milliseconds: 100 * index) : Duration.zero,
      onComplete: (controller) => controller.stop(),
      child: NotificationTile.from(
        key: ValueKey("notification_${notification.id}"),
        notification,
      ),
    );
  }
}
