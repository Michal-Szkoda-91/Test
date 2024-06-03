import 'package:apparence_kit/core/bottom_menu/bottom_router.dart';
import 'package:apparence_kit/core/widgets/responsive_layout.dart';
import 'package:bart/bart.dart' as bart;
import 'package:flutter/material.dart';

/// This bottom menu is powered by Bart packages
/// https://pub.dev/packages/bart
/// It allows you to create a bottom menu with a router and handle
/// all tabs navigation separately.
/// See the bottom_router.dart file to add tabs or subpages to show on tabs
class BottomMenu extends StatelessWidget {
  final String? initialRoute;

  const BottomMenu({
    super.key,
    this.initialRoute,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      small: bart.BartScaffold(
        routesBuilder: subRoutes,
        bottomBar: bart.BartBottomBar.adaptive(),
        initialRoute: initialRoute ?? "/library",
        scaffoldOptions: bart.ScaffoldOptions(
          backgroundColor: Theme.of(context).colorScheme.background,
        ),
        onRouteChanged: (route) {
          // If you want to log tab events to analytics
          // MixpanelAnalyticsApi.instance().logEvent('home/$route', {});
        },
      ),
      medium: bart.BartScaffold(
        routesBuilder: subRoutes,
        bottomBar: bart.BartBottomBar.adaptive(),
        initialRoute: initialRoute ?? "/library",
        scaffoldOptions: bart.ScaffoldOptions(
          backgroundColor: Theme.of(context).colorScheme.background,
        ),
        sideBarOptions: bart.RailSideBarOptions(
          extended: true,
        ),
      ),
    );
  }
}
