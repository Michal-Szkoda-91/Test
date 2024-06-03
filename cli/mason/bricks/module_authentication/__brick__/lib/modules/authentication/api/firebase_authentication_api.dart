import 'package:apparence_kit/firebase_options_dev.dart';
import 'package:apparence_kit/modules/authentication/api/authentication_api_interface.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:apparence_kit/core/data/entities/user_entity.dart';
{{#facebookSignIn}}import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';{{/facebookSignIn}}
import 'package:firebase_auth/firebase_auth.dart';
{{#appleSignIn}}import 'package:flutter/foundation.dart';{{/appleSignIn}}
import 'package:flutter_riverpod/flutter_riverpod.dart';
{{#addGoogleSigninDependency}}import 'package:google_sign_in/google_sign_in.dart';{{/addGoogleSigninDependency}}

final authenticationApiProvider = Provider<AuthenticationApi>(
  (ref) => FirebaseAuthenticationApi(
    FirebaseAuth.instance, 
    FirebaseFunctions.instanceFor(region: 'europe-west1'),
  ),
);

class FirebaseAuthenticationApi implements AuthenticationApi {
  final FirebaseAuth _auth;
  final FirebaseFunctions _firebaseFunctions;

  FirebaseAuthenticationApi(this._auth, this._firebaseFunctions);

  Stream<Credentials?> onAuthStateChange() {
    return _auth.authStateChanges().map((user) {
      if (user == null) {
        return null;
      }
      return Credentials(
        id: user.uid,
        token: "",
      );
    });
  }

  @override
  Future<Credentials?> get() async {
    final user = _auth.currentUser;
    if (user != null) {
      return Future.value(Credentials(id: user.uid, token: ""));
    }
    return null;
  }

  @override
  Future<Credentials> signinAnonymously() {
    return _auth.signInAnonymously().then(
          (value) => Credentials(
            id: value.user!.uid,
            token: value.credential?.token.toString() ?? '',
          ),
        );
  }

  @override
  Future<Credentials> signin(String email, String password) {
    return _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then(
          (value) => Credentials(
            id: value.user!.uid,
            token: value.credential?.token.toString() ?? '',
          ),
        );
  }

  @override
  Future<void> recoverPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> signout() {
    return _auth.signOut();
  }

  @override
  Future<Credentials> signup(String email, String password) async {
    if (_auth.currentUser == null) {
      return _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then(
            (value) => Credentials(
              id: value.user!.uid,
              token: value.credential?.token.toString() ?? '',
            ),
          );
    }
    final credentials = EmailAuthProvider.credential(
      email: email,
      password: password,
    );
    final resultUser = await _auth.currentUser!.linkWithCredential(credentials);
    return Credentials(
      id: resultUser.user!.uid,
      token: resultUser.credential?.token.toString() ?? '',
    );
  }

  @override
  Future<Credentials> signinWithGoogle() async {
    {{#googleSignIn}}final user = FirebaseAuth.instance.currentUser;
    final loginResult = await GoogleSignIn(
      scopes: [
        'email',
        // 'https://www.googleapis.com/auth/contacts.readonly',
      ],
    ).signIn();
    final googleAuth = await loginResult?.authentication;
    final credentials = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return _auth.signInWithCredential(credentials).then(
          (value) => Credentials(
            id: value.user!.uid,
            token: value.credential?.token.toString() ?? '',
          ),
        );{{/googleSignIn}}{{^googleSignIn}}throw UnimplementedError();{{/googleSignIn}}
  }

  {{#anonymous_auth}}/// Sign up with Google and link the account to the current anonymous user.
  /// The anonymous account will now be linked to the Google account.
  /// The user can now sign in with the Google account.
  /// His data will be preserved.
  @override
  Future<Credentials> signupFromAnonymousWithGoogle() async {
    final googleProvider = GoogleAuthProvider();
    googleProvider.addScope('email');
    final credentials = await _auth.currentUser! //
        .linkWithProvider(googleProvider);
    return Credentials(
      id: credentials.user!.uid,
      token: credentials.credential?.token.toString() ?? '',
    );
  }{{/anonymous_auth}}

  {{#anonymous_auth}}/// As firebase does not have any trigger for when a user links an account,
  /// You might want to call this function after it
  /// So you can for example add the user email to your email marketing list
  @override
  Future<void> onLinkedAccount() async {
    try {
      final callable = _firebaseFunctions.httpsCallable(
        'authFunctions-onUserLinkedAccount',
      );
      await callable.call<void>(<String, dynamic>{});
    } catch (err, _) {
      throw Exception(err);
    }
  }{{/anonymous_auth}}

  @override
  Future<Credentials> signinWithGooglePlay() async {
    {{#googlePlaySignIn}}final googleUser = await GoogleSignIn(
      signInOption: SignInOption.games,
    ).signIn();

    final googleAuth = await googleUser?.authentication;
    final credentials = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return _auth.signInWithCredential(credentials).then(
          (value) => Credentials(
            id: value.user!.uid,
            token: value.credential?.token.toString() ?? '',
          ),
        );{{/googlePlaySignIn}}{{^googlePlaySignIn}}throw UnimplementedError();{{/googlePlaySignIn}}
  }

  @override
  Future<Credentials> signinWithApple() async {
    {{#appleSignIn}}final user = FirebaseAuth.instance.currentUser;
    final appleProvider = AppleAuthProvider();
    appleProvider.addScope('email');
    if (kIsWeb) {
      return _auth //
        .signInWithPopup(appleProvider)
        .then((value) => Credentials(
              id: value.user!.uid,
              token: value.credential?.token.toString() ?? '',
            ));
    } else {
      return _auth //
        .signInWithProvider(appleProvider)
        .then((value) => Credentials(
              id: value.user!.uid,
              token: value.credential?.token.toString() ?? '',
            ));
    }{{/appleSignIn}}{{^appleSignIn}}throw UnimplementedError();{{/appleSignIn}}
  }

  {{#anonymous_auth}}/// Sign up with Apple and link the account to the current anonymous user.
  /// The anonymous account will now be linked to the Apple account.
  /// The user can now sign in his Apple account on another device. 
  /// His data will be preserved.
  @override
  Future<Credentials> signupFromAnonymousWithApple() async {
    final appleProvider = AppleAuthProvider();
    appleProvider.addScope('email');
    return _auth.currentUser!
        .linkWithProvider(appleProvider)
        .then((value) => Credentials(
              id: value.user!.uid,
              token: value.credential?.token.toString() ?? '',
            ));
  }{{/anonymous_auth}}

  @override
  Future<Credentials> signinWithFacebook() async {
    {{#facebookSignIn}}final LoginResult loginResult = await FacebookAuth.instance.login();
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider //
        .credential(loginResult.accessToken!.token);
    return _auth.signInWithCredential(facebookAuthCredential).then(
          (value) => Credentials(
            id: value.user!.uid,
            token: value.credential?.token.toString() ?? '',
          ),
        );{{/facebookSignIn}}{{^facebookSignIn}}throw UnimplementedError();{{/facebookSignIn}}
  }
}
