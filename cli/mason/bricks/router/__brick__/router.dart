import 'package:apparence_kit/core/bottom_menu/bottom_menu.dart';
{{#mixpanel}}import 'package:apparence_kit/core/data/api/analytics_api.dart';{{/mixpanel}}
import 'package:apparence_kit/core/guards/authenticated_guard.dart';
import 'package:apparence_kit/core/widgets/page_not_found.dart';
import 'package:apparence_kit/modules/authentication/ui/recover_password_page.dart';
import 'package:apparence_kit/modules/authentication/ui/signin_page.dart';
import 'package:apparence_kit/modules/authentication/ui/signup_page.dart';
{{#withOnboarding}}import 'package:apparence_kit/modules/onboarding/onboarding_page.dart';{{/withOnboarding}}
import 'package:apparence_kit/modules/subscription/ui/premium_page.dart';
{{#firebaseAnalytics}}import 'package:firebase_analytics/firebase_analytics.dart';{{/firebaseAnalytics}}
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final navigatorKey = GlobalKey<NavigatorState>();

GoRouter generateRouter({
  String? initialLocation,
  List<GoRoute>? additionalRoutes,
  List<NavigatorObserver>? observers,
}) {
  return GoRouter(
    initialLocation: '/',
    navigatorKey: navigatorKey,
    errorBuilder: (context, state) => const PageNotFound(),
    observers: [
      {{#mixpanel}}AnalyticsObserver(
        analyticsApi: MixpanelAnalyticsApi.instance(),
      ),{{/mixpanel}}
      {{#firebaseAnalytics}}FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),{{/firebaseAnalytics}}
      ...?observers,
    ],
    routes: [
      GoRoute(
        name: 'home',
        path: '/',
        builder: (context, state) => const AuthenticatedGuard(
          fallbackRoute: {{#withOnboarding}}'/onboarding'{{/withOnboarding}}{{^withOnboarding}}'/signup'{{/withOnboarding}},
          child: BottomMenu(),
        ),
      ),
      {{#withOnboarding}}GoRoute(
        name: 'onboarding',
        path: '/onboarding',
        builder: (context, state) => const OnBoardingPage(),
      ),{{/withOnboarding}}
      GoRoute(
        name: 'signup',
        path: '/signup',
        builder: (context, state) => const SignupPage(),
      ),
      GoRoute(
        name: 'signin',
        path: '/signin',
        builder: (context, state) => const SigninPage(),
      ),
      GoRoute(
        name: 'premium',
        path: '/premium',
        builder: (context, state) => const PremiumPage(),
      ),
      GoRoute(
        name: 'recover_password',
        path: '/recover_password',
        builder: (context, state) => const RecoverPasswordPage(),
      ),
      GoRoute(
        name: '404',
        path: '/404',
        builder: (context, state) => const PageNotFound(),
      ),
    ],
  );
}

