import 'package:apparence_kit/core/theme/extensions/theme_extension.dart';
import 'package:apparence_kit/core/widgets/buttons.dart';
import 'package:apparence_kit/core/widgets/responsive_layout.dart';
import 'package:apparence_kit/core/widgets/toast.dart';
import 'package:apparence_kit/modules/authentication/providers/models/email.dart';
import 'package:apparence_kit/modules/authentication/providers/models/password.dart';
import 'package:apparence_kit/modules/authentication/providers/signup_state_provider.dart';
import 'package:apparence_kit/modules/authentication/repositories/exceptions/authentication_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final _formKey = GlobalKey<FormState>();

class SignupPage extends ConsumerWidget {
  final bool canDismiss;

  const SignupPage({super.key, this.canDismiss = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SizedBox(
        child: PopScope(
          canPop: canDismiss,
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            resizeToAvoidBottomInset: false,
            body: ResponsiveLayout(
              small: const SignupForm(),
              medium: Center(
                child: Container(
                  width: 400,
                  height: 480,
                  color: context.colors.surface,
                  padding: const EdgeInsets.all(24.0),
                  child: const SignupForm(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SignupForm extends ConsumerWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(signupStateProvider);
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
        ),
        child: ListView(
          children: [
            const SizedBox(height: 72),
            Text(
              'Signup now',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 32),
            TextFormField(
              key: const Key('email_input'),
              onChanged: (value) =>
                  ref.read(signupStateProvider.notifier).setEmail(value),
              decoration: const InputDecoration(
                hintText: 'bruce@wayne.com',
                labelText: 'Email',
              ),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: (value) {
                try {
                  state.email.validate();
                } on EmailException catch (e) {
                  return e.message;
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              key: const Key('password_input'),
              onChanged: (newValue) =>
                  ref.read(signupStateProvider.notifier).setPassword(newValue),
              decoration: const InputDecoration(
                hintText: 'Password',
                labelText: 'Password',
              ),
              textInputAction: TextInputAction.done,
              obscureText: true,
              validator: (value) {
                try {
                  state.password.validate();
                } on PasswordException catch (e) {
                  return e.message;
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              key: const Key('send_button'),
              onPressed: () async {
                // hide keyboard
                FocusScope.of(context).unfocus();
                ref
                    .read(signupStateProvider.notifier)
                    .signup()
                    .then(
                      (value) => context.pushReplacement('/'),
                    )
                    .catchError(
                  (err) async {
                    showErrorToast(
                      context: context,
                      title: 'Error',
                      text: (err as SignupException).message ?? '',
                    );
                    return null;
                  },
                  test: (err) => err is SignupException,
                ).catchError(
                  (err) async {
                    showErrorToast(
                      context: context,
                      title: 'Error',
                      text: 'Fill a valid email and password',
                    );
                    return null;
                  },
                );
              },
              child: state.when(
                (_, __) => const Text('Create my account'),
                sending: (_, __) => const ButtonLoading(),
              ),
            ),
            const SizedBox(height: 4),
            TextButton(
              onPressed: () {
                context.pushReplacement('/signin');
              },
              child: const Text(
                "I already have an account",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
