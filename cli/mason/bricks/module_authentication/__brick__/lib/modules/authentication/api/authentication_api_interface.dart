import 'package:apparence_kit/core/data/entities/user_entity.dart';

abstract class AuthenticationApi {
  /// Get the current user credentials or null if not connected
  Future<Credentials?> get();

  /// Signup a new user using [email] and [password]
  Future<Credentials> signup(String email, String password);

  /// Signin an existing user using [email] and [password]
  /// If the user is not found, an [SigninException] is thrown
  Future<Credentials> signin(String email, String password);

  /// Signout the current user
  Future<void> signout();

  /// Signin anonymously
  Future<Credentials> signinAnonymously();

  /// Signin with Google account
  /// Requires the [google_sign_in](https://pub.dev/packages/google_sign_in) package
  Future<Credentials> signinWithGoogle();

  /// Signin with Google Play account
  /// Requires the [google_sign_in](https://pub.dev/packages/google_sign_in) package
  Future<Credentials> signinWithGooglePlay();

  /// Signin with Facebook account
  /// Requires the [flutter_facebook_auth](https://pub.dev/packages/flutter_facebook_auth) package
  Future<Credentials> signinWithFacebook();

  /// Signin with Apple account
  Future<Credentials> signinWithApple();

  /// Recover password if user signed up with email/password
  Future<void> recoverPassword(String email);

  {{#anonymous_auth}}/// As firebase does not have any trigger for when a user links an account,
  /// You might want to call this function after it
  /// So you can for example add the user email to your email marketing list
  Future<void> onLinkedAccount();{{/anonymous_auth}}
  
  {{#anonymous_auth}}/// Sign up with Google and link the account to the current anonymous user.
  /// The anonymous account will now be linked to the Google account.
  /// The user can now sign in with the Google account.
  /// His data will be preserved.
  Future<Credentials> signupFromAnonymousWithGoogle();{{/anonymous_auth}}

  {{#anonymous_auth}}/// Sign up with Apple and link the account to the current anonymous user.
  /// The anonymous account will now be linked to the Apple account.
  /// The user can now sign in his Apple account on another device. 
  /// His data will be preserved.
  Future<Credentials> signupFromAnonymousWithApple();{{/anonymous_auth}}

}
