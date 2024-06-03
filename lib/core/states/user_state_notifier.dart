import 'package:apparence_kit/core/data/models/user.dart';
import 'package:apparence_kit/core/data/repositories/user_repository.dart';
import 'package:apparence_kit/core/initializer/onstart_service.dart';
import 'package:apparence_kit/core/states/models/user_state.dart';
import 'package:apparence_kit/environnements.dart';
import 'package:apparence_kit/modules/authentication/repositories/authentication_repository.dart';
import 'package:apparence_kit/modules/notifications/providers/models/device.dart';
import 'package:apparence_kit/modules/notifications/repositories/device_repository.dart';
import 'package:apparence_kit/modules/subscription/domain/subscription.dart';
import 'package:apparence_kit/modules/subscription/repositories/subscription_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final userStateNotifierProvider =
    StateNotifierProvider<UserStateNotifier, UserState>(
  (ref) => UserStateNotifier(
    authenticationRepository: ref.read(authRepositoryProvider),
    subscriptionRepository: ref.read(subscriptionRepositoryProvider),
    userRepository: ref.read(userRepositoryProvider),
    deviceRepository: ref.read(deviceRepositoryProvider),
    mode: ref.read(environmentProvider).authenticationMode,
  ),
);

/// This enum is used to parameter the list of the authentication mode
///
/// Most of apps try to not force user to create an account to access the app
/// But you may want to force the user to be authenticated to access the app
enum AuthenticationMode {
  /// By default the user will be authenticated anonymously
  /// This means that the user can access your app without login
  /// He will be able to link his account later to an email or social login
  anonymous,

  /// The user requires to be authenticated to access the app
  /// By default the user won't have any identity
  authRequired,
}

/// This class is responsible for managing the state of the user over the app.
/// It will be used to know if the user is connected or not and to get the user
class UserStateNotifier extends StateNotifier<UserState>
    implements OnStartService {
  final AuthenticationRepository _authenticationRepository;
  final SubscriptionRepository _subscriptionRepository;
  final DeviceRepository _deviceRepository;
  final UserRepository _userRepository;
  final Logger _logger;

  /// The authentication mode of the app
  /// see [AuthenticationMode]
  final AuthenticationMode mode;

  UserStateNotifier({
    required AuthenticationRepository authenticationRepository,
    required SubscriptionRepository subscriptionRepository,
    required DeviceRepository deviceRepository,
    required UserRepository userRepository,
    Logger? logger,
    this.mode = AuthenticationMode.anonymous,
  })  : _authenticationRepository = authenticationRepository,
        _subscriptionRepository = subscriptionRepository,
        _userRepository = userRepository,
        _deviceRepository = deviceRepository,
        _logger = logger ?? Logger(),
        super(
          const UserState(
            user: User.loading(),
            subscription: Subscription.loading(),
          ),
        );

  @override
  Future<void> init() async {
    try {
      await _loadState();
    } catch (e, stacktrace) {
      _logger.e(e, stackTrace: stacktrace);
    }
    await _loadSubscription();
    assert(state.user is! LoadingUserData, 'UserStateNotifier is not ready');
    await _initDeviceRegistration();
    _deviceRepository.onTokenUpdate(_onUpdateToken);
  }

  /// This function is called when the user click on the signin button
  /// It will load the user state and register the device to the notification service
  /// It will also load the subscription state
  Future<void> onSignin() async {
    state = const UserState(
      user: User.loading(),
      subscription: Subscription.loading(),
    );
    await _loadState();
    await _initDeviceRegistration();
    await _loadSubscription();
  }

  /// This function is called when the user click on the logout button
  /// It will unregister the device from the notification service
  /// and logout the user
  Future<void> onLogout() async {
    final userId = state.user.idOrThrow;
    _deviceRepository.removeTokenUpdateListener();
    await _deviceRepository.unregister(userId);
    await _authenticationRepository.logout();
    state = const UserState(
      user: User.anonymous(),
      subscription: Subscription.loading(),
    );
    if (mode == AuthenticationMode.anonymous) {
      await _loadAnonymousState();
    }
  }

  /// Refresh the user
  /// TODO: rename this to refresh
  Future<void> onUpdateAvatar() async {
    final user = await _userRepository.get(state.user.idOrThrow);

    state = state.copyWith(
      user: user ?? const User.anonymous(),
    );
  }

  /// This function is called after a user successfuly purchased a subscription
  /// It will refresh the subscription state without waiting for the webhook
  /// (which can take some time and could show a wrong state to the user)
  /// On next app start, the subscription will be refreshed from the webhook result
  Future<void> refreshSubscription({
    SubscriptionProduct? product,
  }) async {
    if (product != null) {
      state = state.copyWith(
        subscription: Subscription.active(
          activeOffer: product,
        ),
      );
      return;
    }
    await Future.delayed(const Duration(seconds: 2));
    await _loadSubscription();
  }

  /// Apple store and Google play stores requires you to be able to delete a user account on demand
  /// Here is the function to do it.
  /// It will delete the user account and logout the user
  Future<void> deleteAccount() async {
    try {
      final userId = state.user.idOrThrow;
      _deviceRepository.removeTokenUpdateListener();
      await _deviceRepository.unregister(userId);
      await _userRepository.delete();
      await _authenticationRepository.logout();
    } catch (e) {
      _logger.e(e);
    }
    state = const UserState(
      user: User.anonymous(),
      subscription: Subscription.inactive(
        hoursBetweenTwoRequests: 0,
      ),
    );

    if (mode == AuthenticationMode.anonymous) {
      await _loadAnonymousState();
    }
  }

  // -------------------------------
  // PRIVATES
  // -------------------------------

  /// load anonymous state for the user
  Future<void> _loadAnonymousState() async {
    await _authenticationRepository.signupAnonymously();
    await Future.delayed(const Duration(seconds: 1));
    final credentials = await _authenticationRepository.get();

    state = state.copyWith(
      user: User.anonymous(id: credentials!.id),
    );
  }

  /// Load the state of the user
  Future<void> _loadState() async {
    final credentials = await _authenticationRepository.get();

    if (credentials == null && mode == AuthenticationMode.anonymous) {
      _logger.i('Anonymous user mode activated, signup anonymously');
      await _loadAnonymousState();
    } else if (credentials == null && mode == AuthenticationMode.authRequired) {
      _logger.i('Authentification required, user is not connected');
      state = state.copyWith(user: User.anonymous());
    } else if (credentials != null) {
      _logger.i('User is connected with id ${credentials.id}');
      final userId = credentials.id;

      // I like to save a User automatically when the user is authenticated
      // Using firestore you can create a trigger to do this with the same document ID as the credentials
      final user = await _userRepository.get(credentials.id);
      state = state.copyWith(
        user: user ?? User.authenticated(id: userId, email: '', name: ''),
      );
    }
  }

  /// If user has an ID we will register his device to send notifications from
  /// the server to the device (only if user has accepted them)
  /// Maybe save your device in UserState if you need it in your app
  Future<void> _initDeviceRegistration() async {
    final userId = state.user.maybeMap(
      authenticated: (user) => user.id,
      anonymous: (user) => user.id,
      orElse: () => null,
    );
    if (userId == null) {
      return;
    }
    try {
      final _ = await _deviceRepository.register(userId);
    } catch (err, stacktrace) {
      _logger.e(err, stackTrace: stacktrace);
      _logger.e('''
          ❌ Your device seems not to be registered.
          Check that you correctly setup a device registration API
          see: `lib/modules/notifications/api/device_api.dart`
        ''');
    }
  }

  /// Load the subscription state of the user
  /// If AuthenticationMode.anonymous is activated,
  /// a user can have a subscription without being authenticated
  Future<void> _loadSubscription() async {
    try {
      final userId = state.user.maybeMap(
        authenticated: (user) => user.id,
        anonymous: (user) => user.id,
        orElse: () => null,
      );
      if (userId == null) {
        return;
      }
      await _subscriptionRepository.initUser(userId);
      final subscription = await _subscriptionRepository.get(userId);
      _logger.i('Subscription is $subscription');
      state = state.copyWith(
        subscription: subscription,
      );
    } catch (e, stacktrace) {
      _logger.e(e, stackTrace: stacktrace);
    }
  }

  /// This function is called when the device token is updated
  /// It will update the token in the database
  Future<void> _onUpdateToken(Device device) async {
    await _deviceRepository.updateToken(device.token);
  }
}
