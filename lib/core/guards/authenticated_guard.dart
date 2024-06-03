import 'package:apparence_kit/core/guards/guard.dart';
import 'package:apparence_kit/core/states/user_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticatedGuard extends ConsumerWidget {
  final Widget child;
  final String fallbackRoute;

  const AuthenticatedGuard({
    super.key,
    required this.child,
    required this.fallbackRoute,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(userStateNotifierProvider);
    return Guard(
      canActivate: authState.user.maybeMap(
        authenticated: (_) async => true,
        anonymous: (user) async => user.id != null,
        orElse: () async => false,
      ),
      fallbackRoute: fallbackRoute,
      child: child,
    );
  }
}
