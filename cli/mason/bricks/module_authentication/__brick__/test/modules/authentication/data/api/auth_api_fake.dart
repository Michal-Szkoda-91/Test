import 'package:apparence_kit/core/data/entities/user_entity.dart';
import 'package:apparence_kit/modules/authentication/api/authentication_api_interface.dart';

/// Fake implementation of [AuthenticationApi]
/// This is useful for testing purposes
class FakeAuthenticationApi implements AuthenticationApi {
  Credentials? current;

  @override
  Future<Credentials> signup(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    current = Credentials(
      id: 'fake-user-id',
      token: 'fake-user-token-1234567890',
    );
    return current!;
  }

  @override
  Future<Credentials> signin(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    current = Credentials(
      id: 'fake-user-id',
      token: 'fake-user-token-1234567890',
    );
    return current!;
  }

  @override
  Future<Credentials> signinAnonymously() async {
    await Future.delayed(const Duration(seconds: 1));
    current = Credentials(
      id: 'fake-user-id-anonymous',
      token: 'fake-user-token-1234567898',
    );
    return current!;
  }

  @override
  Future<void> signout() async {
    current = null;
  }

  @override
  Future<Credentials> signinWithGoogle() async {
    await Future.delayed(const Duration(seconds: 1));
    current = Credentials(
      id: 'fake-user-id',
      token: 'fake-user-token-1234567890',
    );
    return current!;
  }

  @override
  Future<Credentials> signinWithGooglePlay() async {
    await Future.delayed(const Duration(seconds: 1));
    current = Credentials(
      id: 'fake-user-id',
      token: 'fake-user-token-1234567890',
    );
    return current!;
  }

  @override
  Future<Credentials> signinWithApple() async {
    await Future.delayed(const Duration(seconds: 1));
    current = Credentials(
      id: 'fake-user-id',
      token: 'fake-user-token-1234567890',
    );
    return current!;
  }

  @override
  Future<Credentials> signinWithFacebook() async {
    await Future.delayed(const Duration(seconds: 1));
    current = Credentials(
      id: 'fake-user-id',
      token: 'fake-user-token-1234567890',
    );
    return current!;
  }

  @override
  Future<void> recoverPassword(String email) async {
    await Future.delayed(const Duration(milliseconds: 100));
  }

  @override
  Future<Credentials?> get() {
    return Future.value(current);
  }

  {{#anonymous_auth}}
  @override
  Future<void> onLinkedAccount() async {}{{/anonymous_auth}}

  {{#anonymous_auth}}
  @override
  Future<Credentials> signupFromAnonymousWithGoogle() async {
    await Future.delayed(const Duration(seconds: 1));
    current = Credentials(
      id: 'fake-user-id',
      token: 'fake-user-token-1234567890',
    );
    return current!;
  }{{/anonymous_auth}}

  {{#anonymous_auth}}
  @override
  Future<Credentials> signupFromAnonymousWithApple() async {
    await Future.delayed(const Duration(seconds: 1));
    current = Credentials(
      id: 'fake-user-id',
      token: 'fake-user-token-1234567890',
    );
    return current!;
  }{{/anonymous_auth}}
}
