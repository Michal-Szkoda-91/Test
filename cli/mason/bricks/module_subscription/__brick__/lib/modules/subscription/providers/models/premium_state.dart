import 'package:apparence_kit/modules/subscription/domain/subscription.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'premium_state.freezed.dart';

@freezed
class PremiumState with _$PremiumState {
  const factory PremiumState({
    required List<SubscriptionProduct> offers,
    SubscriptionProduct? selectedOffer,
  }) = PremiumStateData;

  const factory PremiumState.active({
    SubscriptionProduct? activeOffer,
  }) = PremiumStateActive;

  const factory PremiumState.loading() = PremiumStateLoading;

  const factory PremiumState.sending({
    required List<SubscriptionProduct> offers,
    required bool isPremium,
    SubscriptionProduct? selectedOffer,
  }) = PremiumStateSending;

  const PremiumState._();

  List<SubscriptionProduct>? get maybeOffers => maybeMap(
        (value) => value.offers,
        sending: (value) => value.offers,
        orElse: () => throw "cannot purchase without offers",
      );
}
