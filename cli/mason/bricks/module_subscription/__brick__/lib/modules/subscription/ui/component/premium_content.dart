import 'package:apparence_kit/modules/subscription/domain/subscription.dart';
import 'package:apparence_kit/modules/subscription/ui/widgets/premium_background.dart';
import 'package:apparence_kit/modules/subscription/ui/widgets/premium_card.dart';
import 'package:apparence_kit/modules/subscription/ui/widgets/premium_feature.dart';
import 'package:apparence_kit/modules/subscription/ui/widgets/selectable_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:universal_io/io.dart';

typedef OnTapSubscription = void Function();
typedef OnTap = void Function();

class PremiumPageContent extends StatelessWidget {
  final List<SubscriptionProduct> offers;
  final OnSelectItem<SubscriptionProduct> onSelectItem;
  final OnTapSubscription? onTap;
  final OnTap? onTapRestore;

  const PremiumPageContent({
    super.key,
    required this.offers,
    required this.onSelectItem,
    required this.onTap,
    required this.onTapRestore,
  });

  @override
  Widget build(BuildContext context) {
    return PremiumBackground(
      bgImagePath: "assets/images/premium-bg.jpg",
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => context.pop(),
            icon: Platform.isIOS
                ? const Icon(Icons.arrow_back_ios)
                : const Icon(Icons.arrow_back),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.white,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: PremiumCard(
                bgColor: Colors.black54,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Animate(
                      effects: const [
                        FadeEffect(
                          delay: Duration(milliseconds: 100),
                          duration: Duration(milliseconds: 300),
                        ),
                      ],
                      child: Text(
                        "Subscribe to",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.albertSans(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Animate(
                      effects: const [
                        FadeEffect(
                          delay: Duration(milliseconds: 200),
                          duration: Duration(milliseconds: 300),
                        ),
                      ],
                      child: Text(
                        "MyAPP Premium",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.albertSans(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      children: AnimateList(
                        interval: 150.ms,
                        delay: 500.ms,
                        effects: [FadeEffect(duration: 300.ms)],
                        children: [
                          const PremiumFeature(
                            text: "Lorem ipsum dolor ",
                          ),
                          const PremiumFeature(
                            text: "Lorem ipsum dolor sit",
                          ),
                          const PremiumFeature(
                            text: "Lorem ipsum dolor lorem ",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    SelectableRowGroup<SubscriptionProduct>(
                      items: offers
                          .map(
                            (el) => SelectableOption(
                              label: el.durationType.name.toUpperCase(),
                              price: el.formattedPrice(context),
                              priceDescription: switch (el.durationType) {
                                DurationType.month =>
                                  "Lorem ipsum dolor sit amet",
                                DurationType.year =>
                                  "Lorem ipsum dolor sit amet",
                                DurationType.lifetime =>
                                  "Lorem ipsum dolor sit amet",
                                _ => 'Lorem ipsum dolor sit amet',
                              },
                              data: el,
                            ),
                          )
                          .toList(),
                      onSelectItem: onSelectItem,
                    ),
                    const SizedBox(height: 24),
                    Animate(
                      effects: const [
                        FadeEffect(
                          delay: Duration(milliseconds: 300),
                          duration: Duration(milliseconds: 300),
                        ),
                        ScaleEffect(
                          delay: Duration(milliseconds: 300),
                          duration: Duration(milliseconds: 1000),
                          curve: Curves.elasticInOut,
                        ),
                      ],
                      child: ElevatedButton(
                        onPressed: onTap,
                        child: onTap != null
                            ? const Text("Subscribe")
                            : const CircularProgressIndicator.adaptive(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 14.0),
              child: TextButton(
                onPressed: onTapRestore != null ? () => onTapRestore!() : null,
                child: onTapRestore != null
                    ? const Text(
                        "Restore my subscription",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    : const CircularProgressIndicator.adaptive(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
