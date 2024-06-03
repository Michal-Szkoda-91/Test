import 'package:apparence_kit/modules/notifications/api/local_notifier.dart';
import 'package:apparence_kit/modules/notifications/providers/models/notification.dart'
    as apparence_kit; // this conflicts with material notification ()
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// this homepage is for demo purpose only
/// You can delete it and start from scratch
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // you can fetch the user state like this
    // final userState = ref.watch(userStateNotifierProvider);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 8),
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Text(
              "Home page",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 24),
            Text(
              '''
Welcome on the ApparenceKit demo
This shows you some of the ApparenceKit templates.

Play with it then start reading the documentation on 
https://apparenceKit.dev/docs.''',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge! //
                  .copyWith(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.onBackground,
                      fontWeight: FontWeight.w300),
            ),
            const SizedBox(height: 24),
            InkWell(
              onTap: () {
                // using rootNavigator: true will make sure the dialog is shown on top of the current page
                // so you don't have the bottom navigation bar on top of the dialog
                context.push('/premium');
              },
              child: Card(
                color: Theme.of(context).colorScheme.primary,
                margin: EdgeInsets.zero,
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Premium card",
                        style: Theme.of(context)
                            .textTheme // <-- use this trick to force flutter formatter having a new line
                            .headlineSmall!
                            .copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Test the premium subscription page",
                        style: Theme.of(context)
                            .textTheme // <-- use this trick to force flutter formatter having a new line
                            .bodyMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () {
                // this is only for showing you how to show notifcations manually
                // normally you should use the notification publisher
                // 🤩 the notifications pushed by the server are automatically shown you don't have to do anything
                final settings = ref.read(notificationsSettingsProvider);
                final localNotifier = ref.read(localNotifierProvider);
                final notif = apparence_kit.Notification.withData(
                  id: 'fake-id',
                  title: 'Notification test',
                  body:
                      "Push a local test notification (won't be added into your notifications list)",
                  createdAt: DateTime.now(),
                  notifier: localNotifier,
                  notifierSettings: settings,
                );
                notif.show();
              },
              child: Card(
                color: Theme.of(context).colorScheme.surface,
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Notification test",
                        style: Theme.of(context)
                            .textTheme // <-- use this trick to force flutter formatter having a new line
                            .headlineSmall!
                            .copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '''
Push a local test notification 
(won't be added into your notifications list)''',
                        style: Theme.of(context)
                            .textTheme // <-- use this trick to force flutter formatter having a new line
                            .bodyMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
