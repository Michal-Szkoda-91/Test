// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UserState {
  User get user => throw _privateConstructorUsedError;
  Subscription get subscription => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserStateCopyWith<UserState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserStateCopyWith<$Res> {
  factory $UserStateCopyWith(UserState value, $Res Function(UserState) then) =
      _$UserStateCopyWithImpl<$Res, UserState>;
  @useResult
  $Res call({User user, Subscription subscription});

  $UserCopyWith<$Res> get user;
  $SubscriptionCopyWith<$Res> get subscription;
}

/// @nodoc
class _$UserStateCopyWithImpl<$Res, $Val extends UserState>
    implements $UserStateCopyWith<$Res> {
  _$UserStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? subscription = null,
  }) {
    return _then(_value.copyWith(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
      subscription: null == subscription
          ? _value.subscription
          : subscription // ignore: cast_nullable_to_non_nullable
              as Subscription,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SubscriptionCopyWith<$Res> get subscription {
    return $SubscriptionCopyWith<$Res>(_value.subscription, (value) {
      return _then(_value.copyWith(subscription: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserStateDataImplCopyWith<$Res>
    implements $UserStateCopyWith<$Res> {
  factory _$$UserStateDataImplCopyWith(
          _$UserStateDataImpl value, $Res Function(_$UserStateDataImpl) then) =
      __$$UserStateDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({User user, Subscription subscription});

  @override
  $UserCopyWith<$Res> get user;
  @override
  $SubscriptionCopyWith<$Res> get subscription;
}

/// @nodoc
class __$$UserStateDataImplCopyWithImpl<$Res>
    extends _$UserStateCopyWithImpl<$Res, _$UserStateDataImpl>
    implements _$$UserStateDataImplCopyWith<$Res> {
  __$$UserStateDataImplCopyWithImpl(
      _$UserStateDataImpl _value, $Res Function(_$UserStateDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? subscription = null,
  }) {
    return _then(_$UserStateDataImpl(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
      subscription: null == subscription
          ? _value.subscription
          : subscription // ignore: cast_nullable_to_non_nullable
              as Subscription,
    ));
  }
}

/// @nodoc

class _$UserStateDataImpl implements UserStateData {
  const _$UserStateDataImpl({required this.user, required this.subscription});

  @override
  final User user;
  @override
  final Subscription subscription;

  @override
  String toString() {
    return 'UserState(user: $user, subscription: $subscription)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserStateDataImpl &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.subscription, subscription) ||
                other.subscription == subscription));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user, subscription);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserStateDataImplCopyWith<_$UserStateDataImpl> get copyWith =>
      __$$UserStateDataImplCopyWithImpl<_$UserStateDataImpl>(this, _$identity);
}

abstract class UserStateData implements UserState {
  const factory UserStateData(
      {required final User user,
      required final Subscription subscription}) = _$UserStateDataImpl;

  @override
  User get user;
  @override
  Subscription get subscription;
  @override
  @JsonKey(ignore: true)
  _$$UserStateDataImplCopyWith<_$UserStateDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
