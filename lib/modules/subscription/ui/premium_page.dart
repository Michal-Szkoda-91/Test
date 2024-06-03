import 'package:apparence_kit/core/widgets/toast.dart';
import 'package:apparence_kit/modules/subscription/providers/premium_page_provider.dart';
import 'package:apparence_kit/modules/subscription/ui/component/active_premium_content.dart';
import 'package:apparence_kit/modules/subscription/ui/component/premium_content.dart';
import 'package:apparence_kit/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PremiumPage extends ConsumerWidget {
  const PremiumPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final premiumState = ref.watch(premiumStateProvider);
    // If you have installed the remote config brick
    // you can use it like this
    // RemoteConfig is amazing to manage and test different settings for paywalls
    // ex: you can test different title and texts
    // final remoteConfigApi = ref.watch(remoteConfigApiProvider);
    // print(remoteConfigApi.subscription.title.value);

    return premiumState.map(
      (state) => PremiumPageContent(
        offers: state.offers,
        onSelectItem: (data) =>
            ref.read(premiumStateProvider.notifier).selectOffer(data),
        onTapRestore: () {
          ref.read(premiumStateProvider.notifier).restore().then(
            (value) {
              showSuccessToast(
                context: navigatorKey.currentContext!,
                title: "Subscription restored",
                text: "Thank you for your trust",
              );
              // uncomment if you prefer going back to the previous page
              // Future.delayed(const Duration(seconds: 2), () {
              //   context.pop();
              // });
            },
            onError: (err) => showErrorToast(
              context: context,
              title: "Error",
              text: "We saved your error",
              reason: "We were unable to restore your subscription",
            ),
          );
        },
        onTap: () {
          ref
              .read(premiumStateProvider.notifier) //
              .purchase()
              .then(
            (value) {
              showSuccessToast(
                context: navigatorKey.currentContext!,
                title: "Subscription successful",
                text: "Thank you for your trust",
              );
              // uncomment if you prefer going back to the previous page
              // Navigator.of(context).pop();
            },
            onError: (err) => showErrorToast(
              context: context,
              title: "Error",
              text: "We saved your error",
              reason: "We were unable to process your subscription",
            ),
          );
        },
      ),
      active: (data) => ActivePremiumContent(
        offer: data.activeOffer,
        onTap: () => ref.read(premiumStateProvider.notifier).unsubscribe(),
      ),
      sending: (data) => PremiumPageContent(
        offers: data.offers,
        onSelectItem: (data) =>
            ref.read(premiumStateProvider.notifier).selectOffer(data),
        onTap: null,
        onTapRestore: null,
      ),
      loading: (_) => const Center(
        child: CircularProgressIndicator.adaptive(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }
}
