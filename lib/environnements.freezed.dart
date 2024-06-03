// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'environnements.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Environment {
// Name of the environment (dev, prod, ...) just for debug purpose
  String get name => throw _privateConstructorUsedError;

  /// Url of your backend API / or Supabase URL / or Firebase Functions region
  String get backendUrl => throw _privateConstructorUsedError;

  /// RevenueCat API key for Android
  /// (only if you want to use in-app purchases with RevenueCat)
  String? get revenueCatAndroidApiKey => throw _privateConstructorUsedError;

  /// RevenueCat API key for iOS
  /// (only if you want to use in-app purchases with RevenueCat)
  String? get revenueCatIOSApiKey => throw _privateConstructorUsedError;

  /// this is used to open the app store page of your app for reviews
  String? get appStoreId => throw _privateConstructorUsedError;

  /// only if you want to use ads
  String? get androidInterstitialAdUnitId => throw _privateConstructorUsedError;

  /// only if you want to use ads
  String? get iOSInterstitialAdUnitID => throw _privateConstructorUsedError;

  /// Environment variable to handle Mixpanel analytics
  /// You can get it from https://mixpanel.com
  String? get mixpanelToken => throw _privateConstructorUsedError;

  /// The default authentication mode of the app (anonymous or authRequired)
  /// See [AuthenticationMode]
  AuthenticationMode get authenticationMode =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String name,
            String backendUrl,
            String? revenueCatAndroidApiKey,
            String? revenueCatIOSApiKey,
            String? appStoreId,
            String? androidInterstitialAdUnitId,
            String? iOSInterstitialAdUnitID,
            String? mixpanelToken,
            AuthenticationMode authenticationMode)
        dev,
    required TResult Function(
            String name,
            String backendUrl,
            String? revenueCatAndroidApiKey,
            String? revenueCatIOSApiKey,
            String? androidInterstitialAdUnitId,
            String? iOSInterstitialAdUnitID,
            String? appStoreId,
            String? sentryDsn,
            String? mixpanelToken,
            AuthenticationMode authenticationMode)
        prod,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String name,
            String backendUrl,
            String? revenueCatAndroidApiKey,
            String? revenueCatIOSApiKey,
            String? appStoreId,
            String? androidInterstitialAdUnitId,
            String? iOSInterstitialAdUnitID,
            String? mixpanelToken,
            AuthenticationMode authenticationMode)?
        dev,
    TResult? Function(
            String name,
            String backendUrl,
            String? revenueCatAndroidApiKey,
            String? revenueCatIOSApiKey,
            String? androidInterstitialAdUnitId,
            String? iOSInterstitialAdUnitID,
            String? appStoreId,
            String? sentryDsn,
            String? mixpanelToken,
            AuthenticationMode authenticationMode)?
        prod,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String name,
            String backendUrl,
            String? revenueCatAndroidApiKey,
            String? revenueCatIOSApiKey,
            String? appStoreId,
            String? androidInterstitialAdUnitId,
            String? iOSInterstitialAdUnitID,
            String? mixpanelToken,
            AuthenticationMode authenticationMode)?
        dev,
    TResult Function(
            String name,
            String backendUrl,
            String? revenueCatAndroidApiKey,
            String? revenueCatIOSApiKey,
            String? androidInterstitialAdUnitId,
            String? iOSInterstitialAdUnitID,
            String? appStoreId,
            String? sentryDsn,
            String? mixpanelToken,
            AuthenticationMode authenticationMode)?
        prod,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DevEnvironment value) dev,
    required TResult Function(ProdEnvironment value) prod,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DevEnvironment value)? dev,
    TResult? Function(ProdEnvironment value)? prod,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DevEnvironment value)? dev,
    TResult Function(ProdEnvironment value)? prod,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EnvironmentCopyWith<Environment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EnvironmentCopyWith<$Res> {
  factory $EnvironmentCopyWith(
          Environment value, $Res Function(Environment) then) =
      _$EnvironmentCopyWithImpl<$Res, Environment>;
  @useResult
  $Res call(
      {String name,
      String backendUrl,
      String? revenueCatAndroidApiKey,
      String? revenueCatIOSApiKey,
      String? appStoreId,
      String? androidInterstitialAdUnitId,
      String? iOSInterstitialAdUnitID,
      String? mixpanelToken,
      AuthenticationMode authenticationMode});
}

/// @nodoc
class _$EnvironmentCopyWithImpl<$Res, $Val extends Environment>
    implements $EnvironmentCopyWith<$Res> {
  _$EnvironmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? backendUrl = null,
    Object? revenueCatAndroidApiKey = freezed,
    Object? revenueCatIOSApiKey = freezed,
    Object? appStoreId = freezed,
    Object? androidInterstitialAdUnitId = freezed,
    Object? iOSInterstitialAdUnitID = freezed,
    Object? mixpanelToken = freezed,
    Object? authenticationMode = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      backendUrl: null == backendUrl
          ? _value.backendUrl
          : backendUrl // ignore: cast_nullable_to_non_nullable
              as String,
      revenueCatAndroidApiKey: freezed == revenueCatAndroidApiKey
          ? _value.revenueCatAndroidApiKey
          : revenueCatAndroidApiKey // ignore: cast_nullable_to_non_nullable
              as String?,
      revenueCatIOSApiKey: freezed == revenueCatIOSApiKey
          ? _value.revenueCatIOSApiKey
          : revenueCatIOSApiKey // ignore: cast_nullable_to_non_nullable
              as String?,
      appStoreId: freezed == appStoreId
          ? _value.appStoreId
          : appStoreId // ignore: cast_nullable_to_non_nullable
              as String?,
      androidInterstitialAdUnitId: freezed == androidInterstitialAdUnitId
          ? _value.androidInterstitialAdUnitId
          : androidInterstitialAdUnitId // ignore: cast_nullable_to_non_nullable
              as String?,
      iOSInterstitialAdUnitID: freezed == iOSInterstitialAdUnitID
          ? _value.iOSInterstitialAdUnitID
          : iOSInterstitialAdUnitID // ignore: cast_nullable_to_non_nullable
              as String?,
      mixpanelToken: freezed == mixpanelToken
          ? _value.mixpanelToken
          : mixpanelToken // ignore: cast_nullable_to_non_nullable
              as String?,
      authenticationMode: null == authenticationMode
          ? _value.authenticationMode
          : authenticationMode // ignore: cast_nullable_to_non_nullable
              as AuthenticationMode,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DevEnvironmentImplCopyWith<$Res>
    implements $EnvironmentCopyWith<$Res> {
  factory _$$DevEnvironmentImplCopyWith(_$DevEnvironmentImpl value,
          $Res Function(_$DevEnvironmentImpl) then) =
      __$$DevEnvironmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String backendUrl,
      String? revenueCatAndroidApiKey,
      String? revenueCatIOSApiKey,
      String? appStoreId,
      String? androidInterstitialAdUnitId,
      String? iOSInterstitialAdUnitID,
      String? mixpanelToken,
      AuthenticationMode authenticationMode});
}

/// @nodoc
class __$$DevEnvironmentImplCopyWithImpl<$Res>
    extends _$EnvironmentCopyWithImpl<$Res, _$DevEnvironmentImpl>
    implements _$$DevEnvironmentImplCopyWith<$Res> {
  __$$DevEnvironmentImplCopyWithImpl(
      _$DevEnvironmentImpl _value, $Res Function(_$DevEnvironmentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? backendUrl = null,
    Object? revenueCatAndroidApiKey = freezed,
    Object? revenueCatIOSApiKey = freezed,
    Object? appStoreId = freezed,
    Object? androidInterstitialAdUnitId = freezed,
    Object? iOSInterstitialAdUnitID = freezed,
    Object? mixpanelToken = freezed,
    Object? authenticationMode = null,
  }) {
    return _then(_$DevEnvironmentImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      backendUrl: null == backendUrl
          ? _value.backendUrl
          : backendUrl // ignore: cast_nullable_to_non_nullable
              as String,
      revenueCatAndroidApiKey: freezed == revenueCatAndroidApiKey
          ? _value.revenueCatAndroidApiKey
          : revenueCatAndroidApiKey // ignore: cast_nullable_to_non_nullable
              as String?,
      revenueCatIOSApiKey: freezed == revenueCatIOSApiKey
          ? _value.revenueCatIOSApiKey
          : revenueCatIOSApiKey // ignore: cast_nullable_to_non_nullable
              as String?,
      appStoreId: freezed == appStoreId
          ? _value.appStoreId
          : appStoreId // ignore: cast_nullable_to_non_nullable
              as String?,
      androidInterstitialAdUnitId: freezed == androidInterstitialAdUnitId
          ? _value.androidInterstitialAdUnitId
          : androidInterstitialAdUnitId // ignore: cast_nullable_to_non_nullable
              as String?,
      iOSInterstitialAdUnitID: freezed == iOSInterstitialAdUnitID
          ? _value.iOSInterstitialAdUnitID
          : iOSInterstitialAdUnitID // ignore: cast_nullable_to_non_nullable
              as String?,
      mixpanelToken: freezed == mixpanelToken
          ? _value.mixpanelToken
          : mixpanelToken // ignore: cast_nullable_to_non_nullable
              as String?,
      authenticationMode: null == authenticationMode
          ? _value.authenticationMode
          : authenticationMode // ignore: cast_nullable_to_non_nullable
              as AuthenticationMode,
    ));
  }
}

/// @nodoc

class _$DevEnvironmentImpl extends DevEnvironment {
  const _$DevEnvironmentImpl(
      {required this.name,
      required this.backendUrl,
      this.revenueCatAndroidApiKey,
      this.revenueCatIOSApiKey,
      this.appStoreId,
      this.androidInterstitialAdUnitId,
      this.iOSInterstitialAdUnitID,
      this.mixpanelToken,
      required this.authenticationMode})
      : super._();

// Name of the environment (dev, prod, ...) just for debug purpose
  @override
  final String name;

  /// Url of your backend API / or Supabase URL / or Firebase Functions region
  @override
  final String backendUrl;

  /// RevenueCat API key for Android
  /// (only if you want to use in-app purchases with RevenueCat)
  @override
  final String? revenueCatAndroidApiKey;

  /// RevenueCat API key for iOS
  /// (only if you want to use in-app purchases with RevenueCat)
  @override
  final String? revenueCatIOSApiKey;

  /// this is used to open the app store page of your app for reviews
  @override
  final String? appStoreId;

  /// only if you want to use ads
  @override
  final String? androidInterstitialAdUnitId;

  /// only if you want to use ads
  @override
  final String? iOSInterstitialAdUnitID;

  /// Environment variable to handle Mixpanel analytics
  /// You can get it from https://mixpanel.com
  @override
  final String? mixpanelToken;

  /// The default authentication mode of the app (anonymous or authRequired)
  /// See [AuthenticationMode]
  @override
  final AuthenticationMode authenticationMode;

  @override
  String toString() {
    return 'Environment.dev(name: $name, backendUrl: $backendUrl, revenueCatAndroidApiKey: $revenueCatAndroidApiKey, revenueCatIOSApiKey: $revenueCatIOSApiKey, appStoreId: $appStoreId, androidInterstitialAdUnitId: $androidInterstitialAdUnitId, iOSInterstitialAdUnitID: $iOSInterstitialAdUnitID, mixpanelToken: $mixpanelToken, authenticationMode: $authenticationMode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DevEnvironmentImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.backendUrl, backendUrl) ||
                other.backendUrl == backendUrl) &&
            (identical(
                    other.revenueCatAndroidApiKey, revenueCatAndroidApiKey) ||
                other.revenueCatAndroidApiKey == revenueCatAndroidApiKey) &&
            (identical(other.revenueCatIOSApiKey, revenueCatIOSApiKey) ||
                other.revenueCatIOSApiKey == revenueCatIOSApiKey) &&
            (identical(other.appStoreId, appStoreId) ||
                other.appStoreId == appStoreId) &&
            (identical(other.androidInterstitialAdUnitId,
                    androidInterstitialAdUnitId) ||
                other.androidInterstitialAdUnitId ==
                    androidInterstitialAdUnitId) &&
            (identical(
                    other.iOSInterstitialAdUnitID, iOSInterstitialAdUnitID) ||
                other.iOSInterstitialAdUnitID == iOSInterstitialAdUnitID) &&
            (identical(other.mixpanelToken, mixpanelToken) ||
                other.mixpanelToken == mixpanelToken) &&
            (identical(other.authenticationMode, authenticationMode) ||
                other.authenticationMode == authenticationMode));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      backendUrl,
      revenueCatAndroidApiKey,
      revenueCatIOSApiKey,
      appStoreId,
      androidInterstitialAdUnitId,
      iOSInterstitialAdUnitID,
      mixpanelToken,
      authenticationMode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DevEnvironmentImplCopyWith<_$DevEnvironmentImpl> get copyWith =>
      __$$DevEnvironmentImplCopyWithImpl<_$DevEnvironmentImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String name,
            String backendUrl,
            String? revenueCatAndroidApiKey,
            String? revenueCatIOSApiKey,
            String? appStoreId,
            String? androidInterstitialAdUnitId,
            String? iOSInterstitialAdUnitID,
            String? mixpanelToken,
            AuthenticationMode authenticationMode)
        dev,
    required TResult Function(
            String name,
            String backendUrl,
            String? revenueCatAndroidApiKey,
            String? revenueCatIOSApiKey,
            String? androidInterstitialAdUnitId,
            String? iOSInterstitialAdUnitID,
            String? appStoreId,
            String? sentryDsn,
            String? mixpanelToken,
            AuthenticationMode authenticationMode)
        prod,
  }) {
    return dev(
        name,
        backendUrl,
        revenueCatAndroidApiKey,
        revenueCatIOSApiKey,
        appStoreId,
        androidInterstitialAdUnitId,
        iOSInterstitialAdUnitID,
        mixpanelToken,
        authenticationMode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String name,
            String backendUrl,
            String? revenueCatAndroidApiKey,
            String? revenueCatIOSApiKey,
            String? appStoreId,
            String? androidInterstitialAdUnitId,
            String? iOSInterstitialAdUnitID,
            String? mixpanelToken,
            AuthenticationMode authenticationMode)?
        dev,
    TResult? Function(
            String name,
            String backendUrl,
            String? revenueCatAndroidApiKey,
            String? revenueCatIOSApiKey,
            String? androidInterstitialAdUnitId,
            String? iOSInterstitialAdUnitID,
            String? appStoreId,
            String? sentryDsn,
            String? mixpanelToken,
            AuthenticationMode authenticationMode)?
        prod,
  }) {
    return dev?.call(
        name,
        backendUrl,
        revenueCatAndroidApiKey,
        revenueCatIOSApiKey,
        appStoreId,
        androidInterstitialAdUnitId,
        iOSInterstitialAdUnitID,
        mixpanelToken,
        authenticationMode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String name,
            String backendUrl,
            String? revenueCatAndroidApiKey,
            String? revenueCatIOSApiKey,
            String? appStoreId,
            String? androidInterstitialAdUnitId,
            String? iOSInterstitialAdUnitID,
            String? mixpanelToken,
            AuthenticationMode authenticationMode)?
        dev,
    TResult Function(
            String name,
            String backendUrl,
            String? revenueCatAndroidApiKey,
            String? revenueCatIOSApiKey,
            String? androidInterstitialAdUnitId,
            String? iOSInterstitialAdUnitID,
            String? appStoreId,
            String? sentryDsn,
            String? mixpanelToken,
            AuthenticationMode authenticationMode)?
        prod,
    required TResult orElse(),
  }) {
    if (dev != null) {
      return dev(
          name,
          backendUrl,
          revenueCatAndroidApiKey,
          revenueCatIOSApiKey,
          appStoreId,
          androidInterstitialAdUnitId,
          iOSInterstitialAdUnitID,
          mixpanelToken,
          authenticationMode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DevEnvironment value) dev,
    required TResult Function(ProdEnvironment value) prod,
  }) {
    return dev(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DevEnvironment value)? dev,
    TResult? Function(ProdEnvironment value)? prod,
  }) {
    return dev?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DevEnvironment value)? dev,
    TResult Function(ProdEnvironment value)? prod,
    required TResult orElse(),
  }) {
    if (dev != null) {
      return dev(this);
    }
    return orElse();
  }
}

abstract class DevEnvironment extends Environment {
  const factory DevEnvironment(
          {required final String name,
          required final String backendUrl,
          final String? revenueCatAndroidApiKey,
          final String? revenueCatIOSApiKey,
          final String? appStoreId,
          final String? androidInterstitialAdUnitId,
          final String? iOSInterstitialAdUnitID,
          final String? mixpanelToken,
          required final AuthenticationMode authenticationMode}) =
      _$DevEnvironmentImpl;
  const DevEnvironment._() : super._();

  @override // Name of the environment (dev, prod, ...) just for debug purpose
  String get name;
  @override

  /// Url of your backend API / or Supabase URL / or Firebase Functions region
  String get backendUrl;
  @override

  /// RevenueCat API key for Android
  /// (only if you want to use in-app purchases with RevenueCat)
  String? get revenueCatAndroidApiKey;
  @override

  /// RevenueCat API key for iOS
  /// (only if you want to use in-app purchases with RevenueCat)
  String? get revenueCatIOSApiKey;
  @override

  /// this is used to open the app store page of your app for reviews
  String? get appStoreId;
  @override

  /// only if you want to use ads
  String? get androidInterstitialAdUnitId;
  @override

  /// only if you want to use ads
  String? get iOSInterstitialAdUnitID;
  @override

  /// Environment variable to handle Mixpanel analytics
  /// You can get it from https://mixpanel.com
  String? get mixpanelToken;
  @override

  /// The default authentication mode of the app (anonymous or authRequired)
  /// See [AuthenticationMode]
  AuthenticationMode get authenticationMode;
  @override
  @JsonKey(ignore: true)
  _$$DevEnvironmentImplCopyWith<_$DevEnvironmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ProdEnvironmentImplCopyWith<$Res>
    implements $EnvironmentCopyWith<$Res> {
  factory _$$ProdEnvironmentImplCopyWith(_$ProdEnvironmentImpl value,
          $Res Function(_$ProdEnvironmentImpl) then) =
      __$$ProdEnvironmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String backendUrl,
      String? revenueCatAndroidApiKey,
      String? revenueCatIOSApiKey,
      String? androidInterstitialAdUnitId,
      String? iOSInterstitialAdUnitID,
      String? appStoreId,
      String? sentryDsn,
      String? mixpanelToken,
      AuthenticationMode authenticationMode});
}

/// @nodoc
class __$$ProdEnvironmentImplCopyWithImpl<$Res>
    extends _$EnvironmentCopyWithImpl<$Res, _$ProdEnvironmentImpl>
    implements _$$ProdEnvironmentImplCopyWith<$Res> {
  __$$ProdEnvironmentImplCopyWithImpl(
      _$ProdEnvironmentImpl _value, $Res Function(_$ProdEnvironmentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? backendUrl = null,
    Object? revenueCatAndroidApiKey = freezed,
    Object? revenueCatIOSApiKey = freezed,
    Object? androidInterstitialAdUnitId = freezed,
    Object? iOSInterstitialAdUnitID = freezed,
    Object? appStoreId = freezed,
    Object? sentryDsn = freezed,
    Object? mixpanelToken = freezed,
    Object? authenticationMode = null,
  }) {
    return _then(_$ProdEnvironmentImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      backendUrl: null == backendUrl
          ? _value.backendUrl
          : backendUrl // ignore: cast_nullable_to_non_nullable
              as String,
      revenueCatAndroidApiKey: freezed == revenueCatAndroidApiKey
          ? _value.revenueCatAndroidApiKey
          : revenueCatAndroidApiKey // ignore: cast_nullable_to_non_nullable
              as String?,
      revenueCatIOSApiKey: freezed == revenueCatIOSApiKey
          ? _value.revenueCatIOSApiKey
          : revenueCatIOSApiKey // ignore: cast_nullable_to_non_nullable
              as String?,
      androidInterstitialAdUnitId: freezed == androidInterstitialAdUnitId
          ? _value.androidInterstitialAdUnitId
          : androidInterstitialAdUnitId // ignore: cast_nullable_to_non_nullable
              as String?,
      iOSInterstitialAdUnitID: freezed == iOSInterstitialAdUnitID
          ? _value.iOSInterstitialAdUnitID
          : iOSInterstitialAdUnitID // ignore: cast_nullable_to_non_nullable
              as String?,
      appStoreId: freezed == appStoreId
          ? _value.appStoreId
          : appStoreId // ignore: cast_nullable_to_non_nullable
              as String?,
      sentryDsn: freezed == sentryDsn
          ? _value.sentryDsn
          : sentryDsn // ignore: cast_nullable_to_non_nullable
              as String?,
      mixpanelToken: freezed == mixpanelToken
          ? _value.mixpanelToken
          : mixpanelToken // ignore: cast_nullable_to_non_nullable
              as String?,
      authenticationMode: null == authenticationMode
          ? _value.authenticationMode
          : authenticationMode // ignore: cast_nullable_to_non_nullable
              as AuthenticationMode,
    ));
  }
}

/// @nodoc

class _$ProdEnvironmentImpl extends ProdEnvironment {
  const _$ProdEnvironmentImpl(
      {required this.name,
      required this.backendUrl,
      this.revenueCatAndroidApiKey,
      this.revenueCatIOSApiKey,
      this.androidInterstitialAdUnitId,
      this.iOSInterstitialAdUnitID,
      this.appStoreId,
      this.sentryDsn,
      this.mixpanelToken,
      required this.authenticationMode})
      : super._();

  @override
  final String name;

  /// Url of your backend API / or Supabase URL / or Firebase Functions region
  @override
  final String backendUrl;

  /// RevenueCat API key for Android
  /// (only if you want to use in-app purchases with RevenueCat)
  @override
  final String? revenueCatAndroidApiKey;

  /// RevenueCat API key for iOS
  /// (only if you want to use in-app purchases with RevenueCat)
  @override
  final String? revenueCatIOSApiKey;

  /// only if you want to use ads
  @override
  final String? androidInterstitialAdUnitId;

  /// only if you want to use ads
  @override
  final String? iOSInterstitialAdUnitID;

  /// this is used to open the app store page of your app for reviews
  @override
  final String? appStoreId;

  /// Sentry is an error reporting tool that will help you to track errors in production
  /// You can get it from https://sentry.io
  /// by default sentry will read the SENTRY_DSN environment variable except for web
  /// you can also setup it directly here. Prefer using environment variables
  @override
  final String? sentryDsn;

  /// Environment variable to handle Mixpanel analytics
  /// You can get it from https://mixpanel.com
  @override
  final String? mixpanelToken;

  /// The default authentication mode of the app (anonymous or authRequired)
  /// See [AuthenticationMode]
  @override
  final AuthenticationMode authenticationMode;

  @override
  String toString() {
    return 'Environment.prod(name: $name, backendUrl: $backendUrl, revenueCatAndroidApiKey: $revenueCatAndroidApiKey, revenueCatIOSApiKey: $revenueCatIOSApiKey, androidInterstitialAdUnitId: $androidInterstitialAdUnitId, iOSInterstitialAdUnitID: $iOSInterstitialAdUnitID, appStoreId: $appStoreId, sentryDsn: $sentryDsn, mixpanelToken: $mixpanelToken, authenticationMode: $authenticationMode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProdEnvironmentImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.backendUrl, backendUrl) ||
                other.backendUrl == backendUrl) &&
            (identical(
                    other.revenueCatAndroidApiKey, revenueCatAndroidApiKey) ||
                other.revenueCatAndroidApiKey == revenueCatAndroidApiKey) &&
            (identical(other.revenueCatIOSApiKey, revenueCatIOSApiKey) ||
                other.revenueCatIOSApiKey == revenueCatIOSApiKey) &&
            (identical(other.androidInterstitialAdUnitId,
                    androidInterstitialAdUnitId) ||
                other.androidInterstitialAdUnitId ==
                    androidInterstitialAdUnitId) &&
            (identical(
                    other.iOSInterstitialAdUnitID, iOSInterstitialAdUnitID) ||
                other.iOSInterstitialAdUnitID == iOSInterstitialAdUnitID) &&
            (identical(other.appStoreId, appStoreId) ||
                other.appStoreId == appStoreId) &&
            (identical(other.sentryDsn, sentryDsn) ||
                other.sentryDsn == sentryDsn) &&
            (identical(other.mixpanelToken, mixpanelToken) ||
                other.mixpanelToken == mixpanelToken) &&
            (identical(other.authenticationMode, authenticationMode) ||
                other.authenticationMode == authenticationMode));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      backendUrl,
      revenueCatAndroidApiKey,
      revenueCatIOSApiKey,
      androidInterstitialAdUnitId,
      iOSInterstitialAdUnitID,
      appStoreId,
      sentryDsn,
      mixpanelToken,
      authenticationMode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProdEnvironmentImplCopyWith<_$ProdEnvironmentImpl> get copyWith =>
      __$$ProdEnvironmentImplCopyWithImpl<_$ProdEnvironmentImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String name,
            String backendUrl,
            String? revenueCatAndroidApiKey,
            String? revenueCatIOSApiKey,
            String? appStoreId,
            String? androidInterstitialAdUnitId,
            String? iOSInterstitialAdUnitID,
            String? mixpanelToken,
            AuthenticationMode authenticationMode)
        dev,
    required TResult Function(
            String name,
            String backendUrl,
            String? revenueCatAndroidApiKey,
            String? revenueCatIOSApiKey,
            String? androidInterstitialAdUnitId,
            String? iOSInterstitialAdUnitID,
            String? appStoreId,
            String? sentryDsn,
            String? mixpanelToken,
            AuthenticationMode authenticationMode)
        prod,
  }) {
    return prod(
        name,
        backendUrl,
        revenueCatAndroidApiKey,
        revenueCatIOSApiKey,
        androidInterstitialAdUnitId,
        iOSInterstitialAdUnitID,
        appStoreId,
        sentryDsn,
        mixpanelToken,
        authenticationMode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String name,
            String backendUrl,
            String? revenueCatAndroidApiKey,
            String? revenueCatIOSApiKey,
            String? appStoreId,
            String? androidInterstitialAdUnitId,
            String? iOSInterstitialAdUnitID,
            String? mixpanelToken,
            AuthenticationMode authenticationMode)?
        dev,
    TResult? Function(
            String name,
            String backendUrl,
            String? revenueCatAndroidApiKey,
            String? revenueCatIOSApiKey,
            String? androidInterstitialAdUnitId,
            String? iOSInterstitialAdUnitID,
            String? appStoreId,
            String? sentryDsn,
            String? mixpanelToken,
            AuthenticationMode authenticationMode)?
        prod,
  }) {
    return prod?.call(
        name,
        backendUrl,
        revenueCatAndroidApiKey,
        revenueCatIOSApiKey,
        androidInterstitialAdUnitId,
        iOSInterstitialAdUnitID,
        appStoreId,
        sentryDsn,
        mixpanelToken,
        authenticationMode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String name,
            String backendUrl,
            String? revenueCatAndroidApiKey,
            String? revenueCatIOSApiKey,
            String? appStoreId,
            String? androidInterstitialAdUnitId,
            String? iOSInterstitialAdUnitID,
            String? mixpanelToken,
            AuthenticationMode authenticationMode)?
        dev,
    TResult Function(
            String name,
            String backendUrl,
            String? revenueCatAndroidApiKey,
            String? revenueCatIOSApiKey,
            String? androidInterstitialAdUnitId,
            String? iOSInterstitialAdUnitID,
            String? appStoreId,
            String? sentryDsn,
            String? mixpanelToken,
            AuthenticationMode authenticationMode)?
        prod,
    required TResult orElse(),
  }) {
    if (prod != null) {
      return prod(
          name,
          backendUrl,
          revenueCatAndroidApiKey,
          revenueCatIOSApiKey,
          androidInterstitialAdUnitId,
          iOSInterstitialAdUnitID,
          appStoreId,
          sentryDsn,
          mixpanelToken,
          authenticationMode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DevEnvironment value) dev,
    required TResult Function(ProdEnvironment value) prod,
  }) {
    return prod(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DevEnvironment value)? dev,
    TResult? Function(ProdEnvironment value)? prod,
  }) {
    return prod?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DevEnvironment value)? dev,
    TResult Function(ProdEnvironment value)? prod,
    required TResult orElse(),
  }) {
    if (prod != null) {
      return prod(this);
    }
    return orElse();
  }
}

abstract class ProdEnvironment extends Environment {
  const factory ProdEnvironment(
          {required final String name,
          required final String backendUrl,
          final String? revenueCatAndroidApiKey,
          final String? revenueCatIOSApiKey,
          final String? androidInterstitialAdUnitId,
          final String? iOSInterstitialAdUnitID,
          final String? appStoreId,
          final String? sentryDsn,
          final String? mixpanelToken,
          required final AuthenticationMode authenticationMode}) =
      _$ProdEnvironmentImpl;
  const ProdEnvironment._() : super._();

  @override
  String get name;
  @override

  /// Url of your backend API / or Supabase URL / or Firebase Functions region
  String get backendUrl;
  @override

  /// RevenueCat API key for Android
  /// (only if you want to use in-app purchases with RevenueCat)
  String? get revenueCatAndroidApiKey;
  @override

  /// RevenueCat API key for iOS
  /// (only if you want to use in-app purchases with RevenueCat)
  String? get revenueCatIOSApiKey;
  @override

  /// only if you want to use ads
  String? get androidInterstitialAdUnitId;
  @override

  /// only if you want to use ads
  String? get iOSInterstitialAdUnitID;
  @override

  /// this is used to open the app store page of your app for reviews
  String? get appStoreId;

  /// Sentry is an error reporting tool that will help you to track errors in production
  /// You can get it from https://sentry.io
  /// by default sentry will read the SENTRY_DSN environment variable except for web
  /// you can also setup it directly here. Prefer using environment variables
  String? get sentryDsn;
  @override

  /// Environment variable to handle Mixpanel analytics
  /// You can get it from https://mixpanel.com
  String? get mixpanelToken;
  @override

  /// The default authentication mode of the app (anonymous or authRequired)
  /// See [AuthenticationMode]
  AuthenticationMode get authenticationMode;
  @override
  @JsonKey(ignore: true)
  _$$ProdEnvironmentImplCopyWith<_$ProdEnvironmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
