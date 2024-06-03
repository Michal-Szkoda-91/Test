import 'package:flutter/widgets.dart';
import 'package:universal_io/io.dart';

enum DeviceType {
  small,
  medium,
  large,
  xlarge,
}

/// A widget that adapts its content to the current device type.
/// It uses the [LayoutBuilder] widget to get the current device width
/// and returns the widget that matches the current device type.
/// Breakpoints are:
/// - small: < 768
/// - medium: >= 768
/// - large: >= 1024
/// - xlarge: >= 1280
/// It's designed as mobile first meaning that if you don't provide a widget
/// for a specific device type, it will fallback to the previous one. (the small widget is required)
class ResponsiveLayout extends StatelessWidget {
  final Widget small;
  final Widget? medium;
  final Widget? large;
  final Widget? xlarge;

  const ResponsiveLayout({
    super.key,
    required this.small,
    this.medium,
    this.large,
    this.xlarge,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final deviceType = getDeviceType(constraints);
        switch (deviceType) {
          case DeviceType.small:
            return small;
          case DeviceType.medium:
            return medium ?? small;
          case DeviceType.large:
            return large ?? medium ?? small;
          case DeviceType.xlarge:
            return xlarge ?? large ?? medium ?? small;
        }
      },
    );
  }

  DeviceType getDeviceType(BoxConstraints constraints) {
    final (android, ios) = (Platform.isAndroid, Platform.isIOS);
    final maxWidth = constraints.maxWidth;
    return switch ((android, ios, maxWidth)) {
      (_, _, >= 1280) => DeviceType.xlarge,
      (_, _, >= 1024) => DeviceType.large,
      (_, _, >= 768) => DeviceType.medium,
      (_, _, _) => DeviceType.small,
    };
  }
}
