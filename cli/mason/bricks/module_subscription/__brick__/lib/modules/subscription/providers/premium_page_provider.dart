import 'package:apparence_kit/core/data/api/analytics_api.dart';
import 'package:apparence_kit/core/data/models/user.dart';
import 'package:apparence_kit/core/states/models/user_state.dart';
import 'package:apparence_kit/core/states/user_state_notifier.dart';
import 'package:apparence_kit/modules/subscription/domain/subscription.dart';
import 'package:apparence_kit/modules/subscription/providers/models/premium_state.dart';
import 'package:apparence_kit/modules/subscription/repositories/subscription_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
{{#sentry}}import 'package:sentry_flutter/sentry_flutter.dart';{{/sentry}}

final premiumStateProvider =
    StateNotifierProvider.autoDispose<PremiumStateNotifier, PremiumState>(
  (ref) {
    return PremiumStateNotifier(
      subscriptionRepository: ref.watch(subscriptionRepositoryProvider),
      userState: ref.watch(userStateNotifierProvider),
      userStateNotifier: ref.read(userStateNotifierProvider.notifier),
      analyticsApi: ref.watch(analyticsApiProvider),
      logger: Logger(),
    );
  },
);

class PremiumStateNotifier extends StateNotifier<PremiumState> {
  final SubscriptionRepository _subscriptionRepository;
  final AnalyticsApi? _analyticsApi;
  final Logger _logger;
  final UserState _userState;
  final UserStateNotifier _userStateNotifier;

  PremiumStateNotifier({
    required UserState userState,
    required UserStateNotifier userStateNotifier,
    required Logger logger,
    required SubscriptionRepository subscriptionRepository,
    AnalyticsApi? analyticsApi,
  })  : _subscriptionRepository = subscriptionRepository,
        _userState = userState,
        _userStateNotifier = userStateNotifier,
        _analyticsApi = analyticsApi,
        _logger = logger,
        super(const PremiumState.loading()) {
    _init();
  }

  Future<void> _init() async {
    try {
      final offers = await _subscriptionRepository.getOffers();
      _userState.subscription.maybeMap(
        active: (subscr) {
          final activeOffer = offers.firstWhere(
            (element) => element.skuId == subscr.activeOffer?.skuId,
            orElse: () => offers.first,
          );
          state = PremiumState.active(
            activeOffer: activeOffer,
          );
        },
        inactive: (_) {
          offers.sort((a, b) => b.price.compareTo(a.price));
          state = PremiumState(
            offers: offers,
            selectedOffer: offers.first,
          );
        },
        orElse: () => const PremiumState(
          offers: [],
        ),
      );
    } catch (err, stack) {
      {{#sentry}}await Sentry.captureException(err, stackTrace: stack);{{/sentry}}
      _logger.e('''
          ...PremiumStateNotifier: init failed, 
          👉 Make sure you have properly setup subscription 
          following our guide (https://apparencekit.dev/docs/monetize/subscription-template/) 
          $err --> $stack
      ''', stackTrace: stack);
      state = const PremiumStateData(offers: []);
    }
  }

  void selectOffer(SubscriptionProduct offer) {
    state = state.maybeMap(
      (value) => value.copyWith(selectedOffer: offer),
      orElse: () => state,
    );
  }

  Future<void> purchase() async {
    final offer = state.maybeMap(
      (value) => value.selectedOffer,
      orElse: () => throw "cannot purchase without selected offer",
    );
    if (offer == null) {
      throw "cannot purchase without selected offer";
    }
    await purchaseOffer(offer);
  }

  Future<void> purchaseOffer(SubscriptionProduct offer) async {
    state = state.map(
      (value) => PremiumState.sending(
        isPremium: false,
        offers: value.offers,
        selectedOffer: offer,
      ),
      active: (value) => throw "cannot purchase while active",
      loading: (_) => throw "cannot purchase while loading",
      sending: (_) => throw "cannot purchase while sending",
    );
    try {
      await _subscriptionRepository.purchase(offer);
      state = PremiumState.active(activeOffer: offer);
      await _analyticsApi?.logEvent(
        "purchase",
        {
          "skuId": offer.skuId,
          "price": offer.price,
          // "promotion": offer.promotion,
          "duration": offer.duration,
        },
      );
      // let's refresh the user state
      await _userStateNotifier.refreshSubscription(product: offer);
    } catch (err, stackTrace) {
      {{#sentry}}await Sentry.captureException(err, stackTrace: stackTrace);{{/sentry}}
      state = PremiumStateData(
        offers: state.maybeOffers!,
        selectedOffer: offer,
      );
      _logger.e("...PremiumStateNotifier: purchase failed $err : $stackTrace");
      throw SubscriptionException(err.toString());
    }
  }

  Future<void> unsubscribe() async {
    // _analytics.logPageOpened("launch_unsubscribe_page");
    await _subscriptionRepository.unsubscribe();
  }

  Future<void> restore() async {
    state = state.map(
      (value) => PremiumState.sending(
        isPremium: false,
        offers: value.offers,
        selectedOffer: value.selectedOffer,
      ),
      active: (value) => throw "cannot purchase while active",
      loading: (_) => throw "cannot purchase while loading",
      sending: (_) => throw "cannot purchase while sending",
    );
    try {
      await _subscriptionRepository.restorePurchase();
    } catch (err, trace) {
      _logger.e("Error while restoring purchase: $err : $trace");
      state = PremiumStateData(
        offers: state.maybeOffers!,
        selectedOffer: state.maybeOffers?.first,
      );
      throw SubscriptionException(err.toString());
    }
  }
}

class SubscriptionException implements Exception {
  final String message;

  SubscriptionException(this.message);
}
