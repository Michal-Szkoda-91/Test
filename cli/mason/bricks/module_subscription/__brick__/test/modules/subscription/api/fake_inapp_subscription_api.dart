import 'package:apparence_kit/modules/subscription/api/inapp_subscription_api.dart';
import 'package:apparence_kit/modules/subscription/domain/subscription.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import 'fake_revenuecat_product.dart';

/// Fake implementation of [RevenueCatPaymentApi]
/// This helps us to test the UI without having to rely on the real RevenueCat API
/// We implement this once and then we can use it in all our tests
/// If we need to change something one day in the API, we just have to change it here
/// If you need to write any other test you don't need to understand the real API and
/// just rely on this fake implementation
class InAppSubscriptionApiFake implements RevenueCatPaymentApi {
  String? userId;
  List<SubscriptionProduct> activeSubscriptions = [];

  @override
  Future<void> disconnectUser() async {}

  @override
  Future<List<SubscriptionProduct>> getActiveSubscription() async {
    return activeSubscriptions;
  }

  @override
  Future<List<Package>> getLastPurchase() {
    // TODO: implement getLastPurchase
    throw UnimplementedError();
  }

  @override
  Future<List<SubscriptionProduct>> getOffers() async {
    return [
      FakeRevenueCatProduct.month(),
      FakeRevenueCatProduct.year(),
    ];
  }

  @override
  Future<List<EntitlementInfo>> getPermissions() {
    // TODO: implement getPermissions
    throw UnimplementedError();
  }

  @override
  Future<void> init() async {}

  @override
  Future<void> initUser(String userId) async {
    this.userId = userId;
  }

  @override
  Future<void> purchase(StoreProduct storeProduct) {
    // TODO: implement purchase
    throw UnimplementedError();
  }

  @override
  Future<void> purchasePackage(Package package) async {
    activeSubscriptions.add(FakeRevenueCatProduct.month());
  }

  @override
  Future<void> restorePurchase() async {}

  @override
  Future<void> unsubscribe() async {}

  @override
  Future<SubscriptionProduct?> getFromProductId(String productId) async {
    return FakeRevenueCatProduct.month();
  }
}
