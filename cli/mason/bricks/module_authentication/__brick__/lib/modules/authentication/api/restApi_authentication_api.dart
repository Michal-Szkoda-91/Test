import 'package:apparence_kit/core/data/api/base_api_exceptions.dart';
import 'package:apparence_kit/core/data/entities/user_entity.dart';
import 'package:apparence_kit/core/data/api/http_client.dart';
import 'package:apparence_kit/modules/authentication/api/authentication_api_interface.dart';
{{#appleSignIn}}
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
{{/appleSignIn}}
import 'package:dio/dio.dart';
{{#facebookSignIn}}
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
{{/facebookSignIn}}
import 'package:flutter_riverpod/flutter_riverpod.dart';
{{#addGoogleSigninDependency}}
import 'package:google_sign_in/google_sign_in.dart';
{{/addGoogleSigninDependency}}
import 'package:logger/logger.dart';


final authenticationApiProvider = Provider<AuthenticationApi>(
  (ref) => HttpAuthenticationApi(
    logger: Logger(),
    client: ref.read(httpClientProvider),
  ),
);

class HttpAuthenticationApi implements AuthenticationApi {
  final Logger _logger;
  final HttpClient _client;

  HttpAuthenticationApi({
    required Logger logger,
    required HttpClient client,
  })  : _logger = logger,
        _client = client;

  @override
  Future<Credentials> signup(String email, String password) async {
    try {
      final response = await _client.post(
        '/auth/signup',
        data: {
          'email': email,
          'password': password,
        },
      );
      return Credentials.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      throw ApiError.fromDioException(e);
    } catch (e) {
      _logger.e(e);
      throw ApiError(
        code: 0,
        message: '$e',
      );
    }
  }

  @override
  Future<Credentials> signin(String email, String password) async {
    try {
      final response = await _client.post(
        '/auth/signin',
        data: {
          'email': email,
          'password': password,
        },
      );
      return Credentials.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      _logger.e(e);
      throw ApiError.fromDioException(e);
    } catch (e) {
      _logger.e(e);
      throw ApiError(
        code: 0,
        message: '$e',
      );
    }
  }

  @override
  Future<void> recoverPassword(String email) async {
    try {
      await _client.post(
        '/auth/recover-password',
        data: {
          'email': email,
        },
      );
    } on DioException catch (e) {
      _logger.e(e);
      throw ApiError.fromDioException(e);
    } catch (e) {
      _logger.e(e);
      throw ApiError(
        code: 0,
        message: '$e',
      );
    }
  }

  @override
  Future<Credentials> signinAnonymously() {
    throw UnimplementedError();
  }

  @override
  Future<void> signout() async {}

  @override
  Future<Credentials> signinWithGoogle() async {
    {{#googleSignIn}}final loginResult = await GoogleSignIn(
      clientId: const String.fromEnvironment('GOOGLE_CLIENT_ID'),
    ).signIn();
    final googleAuth = await loginResult?.authentication;
    throw UnimplementedError('''
    ❌ You must edit lib/modules/authentication/api/authentication_api.dart 
    to send the Oauth2 token result to your backend
    ''');{{/googleSignIn}}
    {{^googleSignIn}}throw UnimplementedError('''
    ❌ call the command 'dart run cli/bin/apparence_cli.dart auth --provider=google'
    then edit lib/modules/authentication/api/authentication_api.dart
    - See docs/social_auth.md for more details
    ''');{{/googleSignIn}}
  }

  @override
  Future<Credentials> signinWithGooglePlay() async {
    {{#googlePlaySignIn}}final googleUser = await GoogleSignIn(
      signInOption: SignInOption.games,
    ).signIn();

    final googleAuth = await googleUser?.authentication;
    throw UnimplementedError('''
    ❌ You must edit lib/modules/authentication/api/authentication_api.dart 
    to send the Oauth2 token result to your backend
    ''');{{/googlePlaySignIn}}
    {{^googlePlaySignIn}}throw UnimplementedError('''
    ❌ call the command 'dart run cli/bin/apparence_cli.dart auth --provider=googlePlay'
    then edit lib/modules/authentication/api/authentication_api.dart
    - See docs/social_auth.md for more details
    ''');{{/googlePlaySignIn}}
  }

  @override
  Future<Credentials> signinWithApple() async {
    {{#appleSignIn}}final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
        // add any other requested scopes
      ],
    );
    throw UnimplementedError('''
    ❌ You must edit lib/modules/authentication/api/authentication_api.dart 
    to send the Oauth2 token result to your backend
    ----------------
    Please follow the instructions here:
    https://pub.dev/packages/sign_in_with_apple
    ''');
    {{/appleSignIn}}
    {{^appleSignIn}}throw UnimplementedError('''
    ❌ call the command 'dart run cli/bin/apparence_cli.dart auth --provider=apple'
    then edit lib/modules/authentication/api/authentication_api.dart
    - See docs/social_auth.md for more details
    ''');{{/appleSignIn}}
  }

  @override
  Future<Credentials> signinWithFacebook() {
    {{#facebookSignIn}}final LoginResult loginResult = await FacebookAuth.instance.login();
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken.token);
    throw UnimplementedError('''
    Please follow the instructions here:
    https://facebook.meedu.app/docs/5.x.x/intro
    ❌ You must edit lib/modules/authentication/api/authentication_api.dart 
    to send the Oauth2 token result to your backend
    ''');{{/facebookSignIn}}
    {{^facebookSignIn}}throw UnimplementedError('''
    ❌ call the command 'dart run cli/bin/apparence_cli.dart auth --provider=facebook'
    then edit lib/modules/authentication/api/authentication_api.dart
    - See docs/social_auth.md for more details
    ''');{{/facebookSignIn}}
  }

  @override
  Future<Credentials?> get() {
    throw UnimplementedError();
  }
}
