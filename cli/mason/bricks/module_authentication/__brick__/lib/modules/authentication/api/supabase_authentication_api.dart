import 'package:apparence_kit/core/data/api/base_api_exceptions.dart';
import 'package:apparence_kit/core/data/api/http_client.dart';
import 'package:apparence_kit/core/data/entities/user_entity.dart';
import 'package:apparence_kit/modules/authentication/api/authentication_api_interface.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final authenticationApiProvider = Provider<AuthenticationApi>(
  (ref) => SupabaseAuthenticationApi(
    client: Supabase.instance.client,
  ),
);

class SupabaseAuthenticationApi implements AuthenticationApi {
  final SupabaseClient client;

  SupabaseAuthenticationApi({
    required this.client,
  });

  @override
  Future<void> recoverPassword(String email) {
    return client.auth.resetPasswordForEmail(email);
  }

  Future<Credentials?> get() async {
    final user = client.auth.currentUser;
    if (user == null) {
      return null;
    }
    return Credentials(id: user.id, token: '');
  }

  @override
  Future<Credentials> signup(String email, String password) async {
    return client.auth
        .signUp(
          email: email,
          password: password,
        )
        .then(
          (value) => Credentials(
            id: value.user!.id,
            token: value.session?.accessToken ?? '',
          ),
        );
  }

  @override
  Future<Credentials> signin(String email, String password) {
    return client.auth
        .signInWithPassword(
          email: email,
          password: password,
        )
        .then(
          (value) => Credentials(
            id: value.user!.id,
            token: value.session?.accessToken ?? '',
          ),
        );
  }

  @override
  Future<Credentials> signinAnonymously() {
    // See https://github.com/supabase/gotrue/issues/68#issuecomment-1836671954
    throw UnimplementedError(
      "Supabase doesn't support anonymous auth. This feature is currently in progress see: https://github.com/supabase/gotrue/issues/68#issuecomment-1836671954",
    );
  }

  @override
  Future<Credentials> signinWithApple() {
    // TODO: implement signinWithApple
    throw UnimplementedError();
  }

  @override
  Future<Credentials> signinWithFacebook() {
    // TODO: implement signinWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<Credentials> signinWithGoogle() {
    // TODO: implement signinWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<Credentials> signinWithGooglePlay() {
    // TODO: implement signinWithGooglePlay
    throw UnimplementedError();
  }

  @override
  Future<void> signout() {
    return client.auth.signOut();
  }
}
