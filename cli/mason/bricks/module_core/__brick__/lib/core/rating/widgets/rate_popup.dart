import 'package:apparence_kit/core/rating/providers/rating_repository.dart';
import 'package:apparence_kit/core/states/user_state_notifier.dart';
{{#translations}}import 'package:apparence_kit/i18n/translations.g.dart';{{/translations}}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

void showRatingPopup(WidgetRef ref) {
  final ratingRepository = ref.watch(ratingRepositoryProvider);
  final userState = ref.watch(userStateNotifierProvider);
  final ratingFuture = ratingRepository.get(userState.user);

  ratingFuture.then((rating) {
    final shouldAsk = rating.shouldAsk();
    Logger().d('should Ask for rating: $shouldAsk');
    if (shouldAsk) {
      showDialog(
        context: ref.context,
        builder: (context) {
          ratingRepository.delay();
          return AlertDialog.adaptive(
            {{#translations}}title: Text(Translations.of(context).rate_popup.title),{{/translations}}
            {{^translations}}title: const Text("Would you have 15s to rate us?"),{{/translations}}
            {{#translations}}content: Text(Translations.of(context).rate_popup.description),{{/translations}}
            {{^translations}}content: const Text("It's fast and very helpful! Thanks a lot!"),{{/translations}}
            actions: <Widget>[
              TextButton(
                {{#translations}}child: Text(Translations.of(context).rate_popup.cancel_button),{{/translations}}
                {{^translations}}child: const Text("Maybe later"),{{/translations}}
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                {{#translations}}child: Text(Translations.of(context).rate_popup.rate_button),{{/translations}}
                {{^translations}}child: const Text("Yes, with pleasure!"),{{/translations}}
                onPressed: () async {
                  Navigator.of(context).pop();
                  await ratingRepository.rate();
                  await rating.showRatingDialog();
                },
              ),
            ],
          );
        },
      );
    }
  });
}
