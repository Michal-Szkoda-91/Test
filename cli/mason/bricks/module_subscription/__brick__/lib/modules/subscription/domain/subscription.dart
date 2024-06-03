import 'package:apparence_kit/i18n/translations.g.dart';
import 'package:apparence_kit/modules/subscription/api/entities/subscription_entity.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

part 'subscription.freezed.dart';

/// A wrapper around the subscription product from RevenueCat 
/// Makes it easier to use in the app with only what we need
/// This also allows us to use a fake implementation for tests
abstract class SubscriptionProduct {
  /// Unique identifier of the product in the store
  String get skuId;

  /// Unique identifier
  String get id;

  /// Description of the subscription from your app
  String get description;

  /// Label of the subscription from the package in revenue cat
  String get label;

  /// Price of the subscription
  double get price;

  /// Duration of the subscription
  Duration get duration;

  /// Promotion of the subscription (configure it in the revenue cat offering json)
  /// Ex:
  /// {
  ///   "promotions": {
  ///     "year": "50% OFF"
  ///   }
  ///}
  String? get promotion;

  /// Formatted price with duration from the user locale
  String formattedPrice(BuildContext context);

  /// Duration type of the subscription (week, month, year, ...)
  DurationType get durationType;
}

class RevenueCatProduct implements SubscriptionProduct {
  final Offering revenueCatOffer;
  final Package revenueCatPackage;

  RevenueCatProduct({
    required this.revenueCatOffer,
    required this.revenueCatPackage,
  });

  @override
  String get skuId => revenueCatPackage.identifier;

  @override
  String get id => revenueCatOffer.identifier;

  @override
  String get description => "";

  @override
  String get label => revenueCatPackage.presentedOfferingContext.offeringIdentifier;

  @override
  double get price => revenueCatPackage.storeProduct.price;

  @override
  String? get promotion {
    if (revenueCatOffer.metadata["promotions"] == null) {
      return null;
    }
    final data =
        revenueCatOffer.metadata["promotions"]! as Map<Object?, Object?>;
    if (data[durationType.name] == null) {
      return null;
    }
    return data[durationType.name]! as String;
  }

  @override
  Duration get duration =>
      switch (revenueCatPackage.storeProduct.subscriptionPeriod) {
        'P1W' => const Duration(days: 7),
        'P1M' => const Duration(days: 30),
        'P3M' => const Duration(days: 90),
        'P6M' => const Duration(days: 180),
        'P1Y' => const Duration(days: 365),
        _ => Duration.zero,
      };

  @override
  DurationType get durationType {
    final durationCpy = duration;
    if (durationCpy.inDays == 7) {
      return DurationType.week;
    } else if (durationCpy.inDays == 30) {
      return DurationType.month;
    } else if (durationCpy.inDays == 90) {
      return DurationType.threeMonth;
    } else if (durationCpy.inDays == 180) {
      return DurationType.sixMonth;
    } else if (durationCpy.inDays == 365) {
      return DurationType.year;
    }
    return DurationType.lifetime;
  }

  @override
  String formattedPrice(BuildContext context) {
    final translatedDuration = switch (durationType) {
      {{#translations}}DurationType.year => Translations.of(context).premium.duration_annual,
      DurationType.month => Translations.of(context).premium.duration_monthly,
      DurationType.lifetime => Translations.of(context).premium.duration_lifetime,{{/translations}}
      {{^translations}}DurationType.year => "Annual",
      DurationType.month => "Monthly",
      DurationType.week => "Weekly",
      DurationType.lifetime => "Lifetime",{{/translations}}
      _ => "",
    };
    return "${revenueCatPackage.storeProduct.priceString}/$translatedDuration";
  }
}

enum DurationType { week, month, threeMonth, sixMonth, year, lifetime }

@freezed
class Subscription with _$Subscription {
  const factory Subscription.active({
    SubscriptionProduct? activeOffer,
  }) = SubscriptionStateData;

  const factory Subscription.inactive({
    required int hoursBetweenTwoRequests,
    DateTime? lastAskingDate,
  }) = SubscriptionInactiveStateData;

  const factory Subscription.loading() = SubscriptionStateLoading;

  const Subscription._();

  factory Subscription.fromEntity(
    SubscriptionEntity? entity,
    DateTime? lastAskingDate, {
    int hoursBetweenTwoRequests = 24,
  }) {
    if (entity == null ||
        (entity.periodEndDate != null &&
            entity.periodEndDate!.isBefore(DateTime.now())) ||
        entity.status == SubscriptionStatus.EXPIRED) {
      return Subscription.inactive(
        hoursBetweenTwoRequests: hoursBetweenTwoRequests,
        lastAskingDate: lastAskingDate,
      );
    }
    return const Subscription.active();
  }

  bool get canPurchase => map(
        active: (_) => false,
        loading: (_) => false,
        inactive: (_) => true,
      );

  bool get isActive => map(
        active: (_) => true,
        loading: (_) => false,
        inactive: (_) => false,
      );

  /// We prevent spamming the user with the subscription paywall
  /// We ask the user to subscribe only once every x hours
  /// This is useful to prevent the user from being annoyed by the subscription paywall
  /// Also we don't show the paywall if the user is already subscribed
  /// 
  /// Tweak the hoursBetweenTwoRequests in the remote config
  bool get shouldAskForSubscription {
    return map(
      active: (_) => false,
      inactive: (subscription) {
        final now = DateTime.now();
        if (subscription.lastAskingDate == null) {
          return true;
        }
        final diff = now.difference(subscription.lastAskingDate!);
        return diff.inHours >= subscription.hoursBetweenTwoRequests;
      },
      loading: (_) => false,
    );
  }
}
