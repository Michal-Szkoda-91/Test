import 'package:apparence_kit/core/data/models/user.dart';
import 'package:apparence_kit/core/initializer/onstart_service.dart';
import 'package:apparence_kit/environnements.dart';
import 'package:flutter/material.dart';
{{#firebase}}import 'package:firebase_analytics/firebase_analytics.dart';{{/firebase}}
import 'package:flutter_riverpod/flutter_riverpod.dart';
{{#mixpanel}}import 'package:mixpanel_flutter/mixpanel_flutter.dart';{{/mixpanel}}

final analyticsApiProvider = Provider<AnalyticsApi>(
  {{#mixpanel}}(ref) => MixpanelAnalyticsApi.instance(),{{/mixpanel}}
  {{#firebase}}(ref) => FirebaseAnalyticsApi.instance(),{{/firebase}}
);

abstract class AnalyticsApi implements OnStartService {
  /// Log an event to your analytics platform
  Future<void> logEvent(String name, Map<String, dynamic> params);

  /// Log a signout event to your analytics platform
  Future<void> logSignout();

  /// Identify a user to your analytics platform
  Future<void> identify(User user);
}

{{#mixpanel}}
class MixpanelAnalyticsApi implements AnalyticsApi {
  final Environment environment;
  Mixpanel? mixpanel;
  MixpanelAnalyticsApi._({
    required this.environment,
  });

  static MixpanelAnalyticsApi? _instance;

  factory MixpanelAnalyticsApi.instance() {
    return _instance ??= MixpanelAnalyticsApi._(
      environment: Environment.fromEnv(),
    );
  }

  @override
  Future<void> init() async {
    if (environment.mixpanelToken == null) {
      return;
    }
    mixpanel = await Mixpanel.init(
      environment.mixpanelToken!,
      trackAutomaticEvents: true,
    );
  }

  @override
  Future<void> logEvent(String name, Map<String, dynamic> params) async {
    mixpanel?.track(name, properties: params);
  }

  @override
  Future<void> logSignout() async {
    mixpanel?.reset();
    mixpanel?.track('logout');
  }

  @override
  Future<void> identify(User user) async {
    mixpanel?.track('login');
    user.maybeMap(
      authenticated: (authenticated) => mixpanel?.identify(authenticated.id!),
      orElse: () => null,
    );
  }
}
{{/mixpanel}}

{{#firebase}}
class FirebaseAnalyticsApi implements AnalyticsApi {
  FirebaseAnalytics _analytics;

  FirebaseAnalyticsApi({
    required FirebaseAnalytics analytics,
  }) : _analytics = analytics;

  factory FirebaseAnalyticsApi.fromInstance() {
    return FirebaseAnalyticsApi(
      analytics: FirebaseAnalytics.instance,
    );
  }

  @override
  Future<void> init() async {}

  @override
  Future<void> logEvent(String name, Map<String, dynamic> params) async {
    return _analytics.logEvent(
      name: name,
      parameters: params,
    );
  }

  @override
  Future<void> logSignout() async {
    return _analytics.logEvent(name: 'logout');
  }

  @override
  Future<void> identify(User user) async {}
}
{{/firebase}}

class AnalyticsObserver extends RouteObserver<ModalRoute<dynamic>> {
  final AnalyticsApi analyticsApi;

  AnalyticsObserver({
    required this.analyticsApi,
  });

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route.settings.name != null) {
      analyticsApi.logEvent(route.settings.name!, {});
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (newRoute?.settings.name != null) {
      analyticsApi.logEvent(newRoute!.settings.name!, {});
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {}

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {}

  @override
  void didStartUserGesture(
    Route<dynamic> route,
    Route<dynamic>? previousRoute,
  ) {}

  @override
  void didStopUserGesture() {}
}
