import 'package:apparence_kit/core/data/models/user.dart';
import 'package:apparence_kit/core/states/models/user_state.dart';
import 'package:apparence_kit/modules/subscription/domain/subscription.dart';
import 'package:apparence_kit/modules/subscription/ui/component/active_premium_content.dart';
import 'package:apparence_kit/modules/subscription/ui/component/premium_content.dart';
import 'package:apparence_kit/modules/subscription/ui/premium_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_utils.dart';
import 'api/fake_inapp_subscription_api.dart';
import 'api/fake_revenuecat_product.dart';
import 'api/fake_subscription_api.dart';

void main() {
  final subscriptionApiFake = SubscriptionApiFake();
  final inAppSubscriptionApiFake = InAppSubscriptionApiFake();

  testWidgets(
    'user is logged in, has a subscription and is premium => should show active premium page',
    (tester) async {
      await tester.pumpPage(
        userState: UserState(
          subscription: Subscription.active(
            activeOffer: FakeRevenueCatProduct.month(),
          ),
          user: User.authenticated(
            id: '1',
            email: 'user@email.com',
            name: 'user name',
            creationDate: DateTime.now().subtract(const Duration(days: 4)),
          ),
        ),
        subscriptionApiFakeOverride: subscriptionApiFake,
        inAppSubscriptionApiFakeOverride: inAppSubscriptionApiFake,
        home: const PremiumPage(),
      );
      expect(find.byType(ActivePremiumContent), findsOneWidget);
    },
  );

  testWidgets(
    'user is logged in, no subscription => should show premium selection page',
    (tester) async {
      await tester.pumpPage(
        userState: UserState(
          subscription: const Subscription.inactive(
            hoursBetweenTwoRequests: 24,
          ),
          user: User.authenticated(
            id: '1',
            email: 'user@email.com',
            name: 'user name',
            creationDate: DateTime.now().subtract(const Duration(days: 4)),
          ),
        ),
        subscriptionApiFakeOverride: subscriptionApiFake,
        inAppSubscriptionApiFakeOverride: inAppSubscriptionApiFake,
        home: const PremiumPage(),
      );
      expect(find.byType(PremiumPageContent), findsOneWidget);
    },
  );

  testWidgets(
    'user is logged in, no subscription, subscribe => should show premium active page',
    (tester) async {
      await tester.pumpPage(
        userState: UserState(
          subscription: const Subscription.inactive(
            hoursBetweenTwoRequests: 24,
          ),
          user: User.authenticated(
            id: '1',
            email: 'user@email.com',
            name: 'user name',
            creationDate: DateTime.now().subtract(const Duration(days: 4)),
          ),
        ),
        subscriptionApiFakeOverride: subscriptionApiFake,
        inAppSubscriptionApiFakeOverride: inAppSubscriptionApiFake,
        home: const PremiumPage(),
      );
      final subscribeBtn = find.byType(ElevatedButton);
      expect(subscribeBtn, findsOneWidget);
      await tester.tap(subscribeBtn);

      await tester.pump(const Duration(milliseconds: 100));
      await tester.pumpAndSettle();
      expect(find.byType(ActivePremiumContent), findsOneWidget);
    },
  );

  testWidgets(
    'user is anonymously logged with id => should show a premium selection',
    (tester) async {
      await tester.pumpPage(
        userState: const UserState(
          subscription: Subscription.inactive(
            hoursBetweenTwoRequests: 24,
          ),
          user: User.anonymous(id: "Test"),
        ),
        subscriptionApiFakeOverride: subscriptionApiFake,
        inAppSubscriptionApiFakeOverride: inAppSubscriptionApiFake,
        home: const PremiumPage(),
      );

      expect(find.byType(PremiumPageContent), findsOneWidget);
    },
  );
}
