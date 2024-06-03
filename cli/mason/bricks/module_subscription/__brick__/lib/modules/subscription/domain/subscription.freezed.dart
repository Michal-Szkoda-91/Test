// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Subscription {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SubscriptionProduct activeOffer) active,
    required TResult Function() inactive,
    required TResult Function() loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SubscriptionProduct activeOffer)? active,
    TResult? Function()? inactive,
    TResult? Function()? loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SubscriptionProduct activeOffer)? active,
    TResult Function()? inactive,
    TResult Function()? loading,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SubscriptionStateData value) active,
    required TResult Function(SubscriptionInactiveStateData value) inactive,
    required TResult Function(SubscriptionStateLoading value) loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SubscriptionStateData value)? active,
    TResult? Function(SubscriptionInactiveStateData value)? inactive,
    TResult? Function(SubscriptionStateLoading value)? loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SubscriptionStateData value)? active,
    TResult Function(SubscriptionInactiveStateData value)? inactive,
    TResult Function(SubscriptionStateLoading value)? loading,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionCopyWith<$Res> {
  factory $SubscriptionCopyWith(
          Subscription value, $Res Function(Subscription) then) =
      _$SubscriptionCopyWithImpl<$Res, Subscription>;
}

/// @nodoc
class _$SubscriptionCopyWithImpl<$Res, $Val extends Subscription>
    implements $SubscriptionCopyWith<$Res> {
  _$SubscriptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$SubscriptionStateDataImplCopyWith<$Res> {
  factory _$$SubscriptionStateDataImplCopyWith(
          _$SubscriptionStateDataImpl value,
          $Res Function(_$SubscriptionStateDataImpl) then) =
      __$$SubscriptionStateDataImplCopyWithImpl<$Res>;
  @useResult
  $Res call({SubscriptionProduct activeOffer});
}

/// @nodoc
class __$$SubscriptionStateDataImplCopyWithImpl<$Res>
    extends _$SubscriptionCopyWithImpl<$Res, _$SubscriptionStateDataImpl>
    implements _$$SubscriptionStateDataImplCopyWith<$Res> {
  __$$SubscriptionStateDataImplCopyWithImpl(_$SubscriptionStateDataImpl _value,
      $Res Function(_$SubscriptionStateDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activeOffer = null,
  }) {
    return _then(_$SubscriptionStateDataImpl(
      activeOffer: null == activeOffer
          ? _value.activeOffer
          : activeOffer // ignore: cast_nullable_to_non_nullable
              as SubscriptionProduct,
    ));
  }
}

/// @nodoc

class _$SubscriptionStateDataImpl extends SubscriptionStateData {
  const _$SubscriptionStateDataImpl({required this.activeOffer}) : super._();

  @override
  final SubscriptionProduct activeOffer;

  @override
  String toString() {
    return 'Subscription.active(activeOffer: $activeOffer)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscriptionStateDataImpl &&
            (identical(other.activeOffer, activeOffer) ||
                other.activeOffer == activeOffer));
  }

  @override
  int get hashCode => Object.hash(runtimeType, activeOffer);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SubscriptionStateDataImplCopyWith<_$SubscriptionStateDataImpl>
      get copyWith => __$$SubscriptionStateDataImplCopyWithImpl<
          _$SubscriptionStateDataImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SubscriptionProduct activeOffer) active,
    required TResult Function() inactive,
    required TResult Function() loading,
  }) {
    return active(activeOffer);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SubscriptionProduct activeOffer)? active,
    TResult? Function()? inactive,
    TResult? Function()? loading,
  }) {
    return active?.call(activeOffer);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SubscriptionProduct activeOffer)? active,
    TResult Function()? inactive,
    TResult Function()? loading,
    required TResult orElse(),
  }) {
    if (active != null) {
      return active(activeOffer);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SubscriptionStateData value) active,
    required TResult Function(SubscriptionInactiveStateData value) inactive,
    required TResult Function(SubscriptionStateLoading value) loading,
  }) {
    return active(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SubscriptionStateData value)? active,
    TResult? Function(SubscriptionInactiveStateData value)? inactive,
    TResult? Function(SubscriptionStateLoading value)? loading,
  }) {
    return active?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SubscriptionStateData value)? active,
    TResult Function(SubscriptionInactiveStateData value)? inactive,
    TResult Function(SubscriptionStateLoading value)? loading,
    required TResult orElse(),
  }) {
    if (active != null) {
      return active(this);
    }
    return orElse();
  }
}

abstract class SubscriptionStateData extends Subscription {
  const factory SubscriptionStateData(
          {required final SubscriptionProduct activeOffer}) =
      _$SubscriptionStateDataImpl;
  const SubscriptionStateData._() : super._();

  SubscriptionProduct get activeOffer;
  @JsonKey(ignore: true)
  _$$SubscriptionStateDataImplCopyWith<_$SubscriptionStateDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SubscriptionInactiveStateDataImplCopyWith<$Res> {
  factory _$$SubscriptionInactiveStateDataImplCopyWith(
          _$SubscriptionInactiveStateDataImpl value,
          $Res Function(_$SubscriptionInactiveStateDataImpl) then) =
      __$$SubscriptionInactiveStateDataImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SubscriptionInactiveStateDataImplCopyWithImpl<$Res>
    extends _$SubscriptionCopyWithImpl<$Res,
        _$SubscriptionInactiveStateDataImpl>
    implements _$$SubscriptionInactiveStateDataImplCopyWith<$Res> {
  __$$SubscriptionInactiveStateDataImplCopyWithImpl(
      _$SubscriptionInactiveStateDataImpl _value,
      $Res Function(_$SubscriptionInactiveStateDataImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SubscriptionInactiveStateDataImpl
    extends SubscriptionInactiveStateData {
  const _$SubscriptionInactiveStateDataImpl() : super._();

  @override
  String toString() {
    return 'Subscription.inactive()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscriptionInactiveStateDataImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SubscriptionProduct activeOffer) active,
    required TResult Function() inactive,
    required TResult Function() loading,
  }) {
    return inactive();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SubscriptionProduct activeOffer)? active,
    TResult? Function()? inactive,
    TResult? Function()? loading,
  }) {
    return inactive?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SubscriptionProduct activeOffer)? active,
    TResult Function()? inactive,
    TResult Function()? loading,
    required TResult orElse(),
  }) {
    if (inactive != null) {
      return inactive();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SubscriptionStateData value) active,
    required TResult Function(SubscriptionInactiveStateData value) inactive,
    required TResult Function(SubscriptionStateLoading value) loading,
  }) {
    return inactive(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SubscriptionStateData value)? active,
    TResult? Function(SubscriptionInactiveStateData value)? inactive,
    TResult? Function(SubscriptionStateLoading value)? loading,
  }) {
    return inactive?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SubscriptionStateData value)? active,
    TResult Function(SubscriptionInactiveStateData value)? inactive,
    TResult Function(SubscriptionStateLoading value)? loading,
    required TResult orElse(),
  }) {
    if (inactive != null) {
      return inactive(this);
    }
    return orElse();
  }
}

abstract class SubscriptionInactiveStateData extends Subscription {
  const factory SubscriptionInactiveStateData() =
      _$SubscriptionInactiveStateDataImpl;
  const SubscriptionInactiveStateData._() : super._();
}

/// @nodoc
abstract class _$$SubscriptionStateLoadingImplCopyWith<$Res> {
  factory _$$SubscriptionStateLoadingImplCopyWith(
          _$SubscriptionStateLoadingImpl value,
          $Res Function(_$SubscriptionStateLoadingImpl) then) =
      __$$SubscriptionStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SubscriptionStateLoadingImplCopyWithImpl<$Res>
    extends _$SubscriptionCopyWithImpl<$Res, _$SubscriptionStateLoadingImpl>
    implements _$$SubscriptionStateLoadingImplCopyWith<$Res> {
  __$$SubscriptionStateLoadingImplCopyWithImpl(
      _$SubscriptionStateLoadingImpl _value,
      $Res Function(_$SubscriptionStateLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SubscriptionStateLoadingImpl extends SubscriptionStateLoading {
  const _$SubscriptionStateLoadingImpl() : super._();

  @override
  String toString() {
    return 'Subscription.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscriptionStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SubscriptionProduct activeOffer) active,
    required TResult Function() inactive,
    required TResult Function() loading,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SubscriptionProduct activeOffer)? active,
    TResult? Function()? inactive,
    TResult? Function()? loading,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SubscriptionProduct activeOffer)? active,
    TResult Function()? inactive,
    TResult Function()? loading,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SubscriptionStateData value) active,
    required TResult Function(SubscriptionInactiveStateData value) inactive,
    required TResult Function(SubscriptionStateLoading value) loading,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SubscriptionStateData value)? active,
    TResult? Function(SubscriptionInactiveStateData value)? inactive,
    TResult? Function(SubscriptionStateLoading value)? loading,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SubscriptionStateData value)? active,
    TResult Function(SubscriptionInactiveStateData value)? inactive,
    TResult Function(SubscriptionStateLoading value)? loading,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class SubscriptionStateLoading extends Subscription {
  const factory SubscriptionStateLoading() = _$SubscriptionStateLoadingImpl;
  const SubscriptionStateLoading._() : super._();
}
