// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'premium_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PremiumState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<SubscriptionProduct> offers,
            SubscriptionProduct? selectedOffer)
        $default, {
    required TResult Function(SubscriptionProduct? activeOffer) active,
    required TResult Function() loading,
    required TResult Function(List<SubscriptionProduct> offers, bool isPremium,
            SubscriptionProduct? selectedOffer)
        sending,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(List<SubscriptionProduct> offers,
            SubscriptionProduct? selectedOffer)?
        $default, {
    TResult? Function(SubscriptionProduct? activeOffer)? active,
    TResult? Function()? loading,
    TResult? Function(List<SubscriptionProduct> offers, bool isPremium,
            SubscriptionProduct? selectedOffer)?
        sending,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<SubscriptionProduct> offers,
            SubscriptionProduct? selectedOffer)?
        $default, {
    TResult Function(SubscriptionProduct? activeOffer)? active,
    TResult Function()? loading,
    TResult Function(List<SubscriptionProduct> offers, bool isPremium,
            SubscriptionProduct? selectedOffer)?
        sending,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(PremiumStateData value) $default, {
    required TResult Function(PremiumStateActive value) active,
    required TResult Function(PremiumStateLoading value) loading,
    required TResult Function(PremiumStateSending value) sending,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(PremiumStateData value)? $default, {
    TResult? Function(PremiumStateActive value)? active,
    TResult? Function(PremiumStateLoading value)? loading,
    TResult? Function(PremiumStateSending value)? sending,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(PremiumStateData value)? $default, {
    TResult Function(PremiumStateActive value)? active,
    TResult Function(PremiumStateLoading value)? loading,
    TResult Function(PremiumStateSending value)? sending,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PremiumStateCopyWith<$Res> {
  factory $PremiumStateCopyWith(
          PremiumState value, $Res Function(PremiumState) then) =
      _$PremiumStateCopyWithImpl<$Res, PremiumState>;
}

/// @nodoc
class _$PremiumStateCopyWithImpl<$Res, $Val extends PremiumState>
    implements $PremiumStateCopyWith<$Res> {
  _$PremiumStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$PremiumStateDataImplCopyWith<$Res> {
  factory _$$PremiumStateDataImplCopyWith(_$PremiumStateDataImpl value,
          $Res Function(_$PremiumStateDataImpl) then) =
      __$$PremiumStateDataImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<SubscriptionProduct> offers, SubscriptionProduct? selectedOffer});
}

/// @nodoc
class __$$PremiumStateDataImplCopyWithImpl<$Res>
    extends _$PremiumStateCopyWithImpl<$Res, _$PremiumStateDataImpl>
    implements _$$PremiumStateDataImplCopyWith<$Res> {
  __$$PremiumStateDataImplCopyWithImpl(_$PremiumStateDataImpl _value,
      $Res Function(_$PremiumStateDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? offers = null,
    Object? selectedOffer = freezed,
  }) {
    return _then(_$PremiumStateDataImpl(
      offers: null == offers
          ? _value._offers
          : offers // ignore: cast_nullable_to_non_nullable
              as List<SubscriptionProduct>,
      selectedOffer: freezed == selectedOffer
          ? _value.selectedOffer
          : selectedOffer // ignore: cast_nullable_to_non_nullable
              as SubscriptionProduct?,
    ));
  }
}

/// @nodoc

class _$PremiumStateDataImpl extends PremiumStateData {
  const _$PremiumStateDataImpl(
      {required final List<SubscriptionProduct> offers, this.selectedOffer})
      : _offers = offers,
        super._();

  final List<SubscriptionProduct> _offers;
  @override
  List<SubscriptionProduct> get offers {
    if (_offers is EqualUnmodifiableListView) return _offers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_offers);
  }

  @override
  final SubscriptionProduct? selectedOffer;

  @override
  String toString() {
    return 'PremiumState(offers: $offers, selectedOffer: $selectedOffer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PremiumStateDataImpl &&
            const DeepCollectionEquality().equals(other._offers, _offers) &&
            (identical(other.selectedOffer, selectedOffer) ||
                other.selectedOffer == selectedOffer));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_offers), selectedOffer);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PremiumStateDataImplCopyWith<_$PremiumStateDataImpl> get copyWith =>
      __$$PremiumStateDataImplCopyWithImpl<_$PremiumStateDataImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<SubscriptionProduct> offers,
            SubscriptionProduct? selectedOffer)
        $default, {
    required TResult Function(SubscriptionProduct? activeOffer) active,
    required TResult Function() loading,
    required TResult Function(List<SubscriptionProduct> offers, bool isPremium,
            SubscriptionProduct? selectedOffer)
        sending,
  }) {
    return $default(offers, selectedOffer);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(List<SubscriptionProduct> offers,
            SubscriptionProduct? selectedOffer)?
        $default, {
    TResult? Function(SubscriptionProduct? activeOffer)? active,
    TResult? Function()? loading,
    TResult? Function(List<SubscriptionProduct> offers, bool isPremium,
            SubscriptionProduct? selectedOffer)?
        sending,
  }) {
    return $default?.call(offers, selectedOffer);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<SubscriptionProduct> offers,
            SubscriptionProduct? selectedOffer)?
        $default, {
    TResult Function(SubscriptionProduct? activeOffer)? active,
    TResult Function()? loading,
    TResult Function(List<SubscriptionProduct> offers, bool isPremium,
            SubscriptionProduct? selectedOffer)?
        sending,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(offers, selectedOffer);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(PremiumStateData value) $default, {
    required TResult Function(PremiumStateActive value) active,
    required TResult Function(PremiumStateLoading value) loading,
    required TResult Function(PremiumStateSending value) sending,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(PremiumStateData value)? $default, {
    TResult? Function(PremiumStateActive value)? active,
    TResult? Function(PremiumStateLoading value)? loading,
    TResult? Function(PremiumStateSending value)? sending,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(PremiumStateData value)? $default, {
    TResult Function(PremiumStateActive value)? active,
    TResult Function(PremiumStateLoading value)? loading,
    TResult Function(PremiumStateSending value)? sending,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class PremiumStateData extends PremiumState {
  const factory PremiumStateData(
      {required final List<SubscriptionProduct> offers,
      final SubscriptionProduct? selectedOffer}) = _$PremiumStateDataImpl;
  const PremiumStateData._() : super._();

  List<SubscriptionProduct> get offers;
  SubscriptionProduct? get selectedOffer;
  @JsonKey(ignore: true)
  _$$PremiumStateDataImplCopyWith<_$PremiumStateDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PremiumStateActiveImplCopyWith<$Res> {
  factory _$$PremiumStateActiveImplCopyWith(_$PremiumStateActiveImpl value,
          $Res Function(_$PremiumStateActiveImpl) then) =
      __$$PremiumStateActiveImplCopyWithImpl<$Res>;
  @useResult
  $Res call({SubscriptionProduct? activeOffer});
}

/// @nodoc
class __$$PremiumStateActiveImplCopyWithImpl<$Res>
    extends _$PremiumStateCopyWithImpl<$Res, _$PremiumStateActiveImpl>
    implements _$$PremiumStateActiveImplCopyWith<$Res> {
  __$$PremiumStateActiveImplCopyWithImpl(_$PremiumStateActiveImpl _value,
      $Res Function(_$PremiumStateActiveImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activeOffer = freezed,
  }) {
    return _then(_$PremiumStateActiveImpl(
      activeOffer: freezed == activeOffer
          ? _value.activeOffer
          : activeOffer // ignore: cast_nullable_to_non_nullable
              as SubscriptionProduct?,
    ));
  }
}

/// @nodoc

class _$PremiumStateActiveImpl extends PremiumStateActive {
  const _$PremiumStateActiveImpl({this.activeOffer}) : super._();

  @override
  final SubscriptionProduct? activeOffer;

  @override
  String toString() {
    return 'PremiumState.active(activeOffer: $activeOffer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PremiumStateActiveImpl &&
            (identical(other.activeOffer, activeOffer) ||
                other.activeOffer == activeOffer));
  }

  @override
  int get hashCode => Object.hash(runtimeType, activeOffer);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PremiumStateActiveImplCopyWith<_$PremiumStateActiveImpl> get copyWith =>
      __$$PremiumStateActiveImplCopyWithImpl<_$PremiumStateActiveImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<SubscriptionProduct> offers,
            SubscriptionProduct? selectedOffer)
        $default, {
    required TResult Function(SubscriptionProduct? activeOffer) active,
    required TResult Function() loading,
    required TResult Function(List<SubscriptionProduct> offers, bool isPremium,
            SubscriptionProduct? selectedOffer)
        sending,
  }) {
    return active(activeOffer);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(List<SubscriptionProduct> offers,
            SubscriptionProduct? selectedOffer)?
        $default, {
    TResult? Function(SubscriptionProduct? activeOffer)? active,
    TResult? Function()? loading,
    TResult? Function(List<SubscriptionProduct> offers, bool isPremium,
            SubscriptionProduct? selectedOffer)?
        sending,
  }) {
    return active?.call(activeOffer);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<SubscriptionProduct> offers,
            SubscriptionProduct? selectedOffer)?
        $default, {
    TResult Function(SubscriptionProduct? activeOffer)? active,
    TResult Function()? loading,
    TResult Function(List<SubscriptionProduct> offers, bool isPremium,
            SubscriptionProduct? selectedOffer)?
        sending,
    required TResult orElse(),
  }) {
    if (active != null) {
      return active(activeOffer);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(PremiumStateData value) $default, {
    required TResult Function(PremiumStateActive value) active,
    required TResult Function(PremiumStateLoading value) loading,
    required TResult Function(PremiumStateSending value) sending,
  }) {
    return active(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(PremiumStateData value)? $default, {
    TResult? Function(PremiumStateActive value)? active,
    TResult? Function(PremiumStateLoading value)? loading,
    TResult? Function(PremiumStateSending value)? sending,
  }) {
    return active?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(PremiumStateData value)? $default, {
    TResult Function(PremiumStateActive value)? active,
    TResult Function(PremiumStateLoading value)? loading,
    TResult Function(PremiumStateSending value)? sending,
    required TResult orElse(),
  }) {
    if (active != null) {
      return active(this);
    }
    return orElse();
  }
}

abstract class PremiumStateActive extends PremiumState {
  const factory PremiumStateActive({final SubscriptionProduct? activeOffer}) =
      _$PremiumStateActiveImpl;
  const PremiumStateActive._() : super._();

  SubscriptionProduct? get activeOffer;
  @JsonKey(ignore: true)
  _$$PremiumStateActiveImplCopyWith<_$PremiumStateActiveImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PremiumStateLoadingImplCopyWith<$Res> {
  factory _$$PremiumStateLoadingImplCopyWith(_$PremiumStateLoadingImpl value,
          $Res Function(_$PremiumStateLoadingImpl) then) =
      __$$PremiumStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PremiumStateLoadingImplCopyWithImpl<$Res>
    extends _$PremiumStateCopyWithImpl<$Res, _$PremiumStateLoadingImpl>
    implements _$$PremiumStateLoadingImplCopyWith<$Res> {
  __$$PremiumStateLoadingImplCopyWithImpl(_$PremiumStateLoadingImpl _value,
      $Res Function(_$PremiumStateLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$PremiumStateLoadingImpl extends PremiumStateLoading {
  const _$PremiumStateLoadingImpl() : super._();

  @override
  String toString() {
    return 'PremiumState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PremiumStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<SubscriptionProduct> offers,
            SubscriptionProduct? selectedOffer)
        $default, {
    required TResult Function(SubscriptionProduct? activeOffer) active,
    required TResult Function() loading,
    required TResult Function(List<SubscriptionProduct> offers, bool isPremium,
            SubscriptionProduct? selectedOffer)
        sending,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(List<SubscriptionProduct> offers,
            SubscriptionProduct? selectedOffer)?
        $default, {
    TResult? Function(SubscriptionProduct? activeOffer)? active,
    TResult? Function()? loading,
    TResult? Function(List<SubscriptionProduct> offers, bool isPremium,
            SubscriptionProduct? selectedOffer)?
        sending,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<SubscriptionProduct> offers,
            SubscriptionProduct? selectedOffer)?
        $default, {
    TResult Function(SubscriptionProduct? activeOffer)? active,
    TResult Function()? loading,
    TResult Function(List<SubscriptionProduct> offers, bool isPremium,
            SubscriptionProduct? selectedOffer)?
        sending,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(PremiumStateData value) $default, {
    required TResult Function(PremiumStateActive value) active,
    required TResult Function(PremiumStateLoading value) loading,
    required TResult Function(PremiumStateSending value) sending,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(PremiumStateData value)? $default, {
    TResult? Function(PremiumStateActive value)? active,
    TResult? Function(PremiumStateLoading value)? loading,
    TResult? Function(PremiumStateSending value)? sending,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(PremiumStateData value)? $default, {
    TResult Function(PremiumStateActive value)? active,
    TResult Function(PremiumStateLoading value)? loading,
    TResult Function(PremiumStateSending value)? sending,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class PremiumStateLoading extends PremiumState {
  const factory PremiumStateLoading() = _$PremiumStateLoadingImpl;
  const PremiumStateLoading._() : super._();
}

/// @nodoc
abstract class _$$PremiumStateSendingImplCopyWith<$Res> {
  factory _$$PremiumStateSendingImplCopyWith(_$PremiumStateSendingImpl value,
          $Res Function(_$PremiumStateSendingImpl) then) =
      __$$PremiumStateSendingImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<SubscriptionProduct> offers,
      bool isPremium,
      SubscriptionProduct? selectedOffer});
}

/// @nodoc
class __$$PremiumStateSendingImplCopyWithImpl<$Res>
    extends _$PremiumStateCopyWithImpl<$Res, _$PremiumStateSendingImpl>
    implements _$$PremiumStateSendingImplCopyWith<$Res> {
  __$$PremiumStateSendingImplCopyWithImpl(_$PremiumStateSendingImpl _value,
      $Res Function(_$PremiumStateSendingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? offers = null,
    Object? isPremium = null,
    Object? selectedOffer = freezed,
  }) {
    return _then(_$PremiumStateSendingImpl(
      offers: null == offers
          ? _value._offers
          : offers // ignore: cast_nullable_to_non_nullable
              as List<SubscriptionProduct>,
      isPremium: null == isPremium
          ? _value.isPremium
          : isPremium // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedOffer: freezed == selectedOffer
          ? _value.selectedOffer
          : selectedOffer // ignore: cast_nullable_to_non_nullable
              as SubscriptionProduct?,
    ));
  }
}

/// @nodoc

class _$PremiumStateSendingImpl extends PremiumStateSending {
  const _$PremiumStateSendingImpl(
      {required final List<SubscriptionProduct> offers,
      required this.isPremium,
      this.selectedOffer})
      : _offers = offers,
        super._();

  final List<SubscriptionProduct> _offers;
  @override
  List<SubscriptionProduct> get offers {
    if (_offers is EqualUnmodifiableListView) return _offers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_offers);
  }

  @override
  final bool isPremium;
  @override
  final SubscriptionProduct? selectedOffer;

  @override
  String toString() {
    return 'PremiumState.sending(offers: $offers, isPremium: $isPremium, selectedOffer: $selectedOffer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PremiumStateSendingImpl &&
            const DeepCollectionEquality().equals(other._offers, _offers) &&
            (identical(other.isPremium, isPremium) ||
                other.isPremium == isPremium) &&
            (identical(other.selectedOffer, selectedOffer) ||
                other.selectedOffer == selectedOffer));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_offers), isPremium, selectedOffer);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PremiumStateSendingImplCopyWith<_$PremiumStateSendingImpl> get copyWith =>
      __$$PremiumStateSendingImplCopyWithImpl<_$PremiumStateSendingImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<SubscriptionProduct> offers,
            SubscriptionProduct? selectedOffer)
        $default, {
    required TResult Function(SubscriptionProduct? activeOffer) active,
    required TResult Function() loading,
    required TResult Function(List<SubscriptionProduct> offers, bool isPremium,
            SubscriptionProduct? selectedOffer)
        sending,
  }) {
    return sending(offers, isPremium, selectedOffer);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(List<SubscriptionProduct> offers,
            SubscriptionProduct? selectedOffer)?
        $default, {
    TResult? Function(SubscriptionProduct? activeOffer)? active,
    TResult? Function()? loading,
    TResult? Function(List<SubscriptionProduct> offers, bool isPremium,
            SubscriptionProduct? selectedOffer)?
        sending,
  }) {
    return sending?.call(offers, isPremium, selectedOffer);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<SubscriptionProduct> offers,
            SubscriptionProduct? selectedOffer)?
        $default, {
    TResult Function(SubscriptionProduct? activeOffer)? active,
    TResult Function()? loading,
    TResult Function(List<SubscriptionProduct> offers, bool isPremium,
            SubscriptionProduct? selectedOffer)?
        sending,
    required TResult orElse(),
  }) {
    if (sending != null) {
      return sending(offers, isPremium, selectedOffer);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(PremiumStateData value) $default, {
    required TResult Function(PremiumStateActive value) active,
    required TResult Function(PremiumStateLoading value) loading,
    required TResult Function(PremiumStateSending value) sending,
  }) {
    return sending(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(PremiumStateData value)? $default, {
    TResult? Function(PremiumStateActive value)? active,
    TResult? Function(PremiumStateLoading value)? loading,
    TResult? Function(PremiumStateSending value)? sending,
  }) {
    return sending?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(PremiumStateData value)? $default, {
    TResult Function(PremiumStateActive value)? active,
    TResult Function(PremiumStateLoading value)? loading,
    TResult Function(PremiumStateSending value)? sending,
    required TResult orElse(),
  }) {
    if (sending != null) {
      return sending(this);
    }
    return orElse();
  }
}

abstract class PremiumStateSending extends PremiumState {
  const factory PremiumStateSending(
      {required final List<SubscriptionProduct> offers,
      required final bool isPremium,
      final SubscriptionProduct? selectedOffer}) = _$PremiumStateSendingImpl;
  const PremiumStateSending._() : super._();

  List<SubscriptionProduct> get offers;
  bool get isPremium;
  SubscriptionProduct? get selectedOffer;
  @JsonKey(ignore: true)
  _$$PremiumStateSendingImplCopyWith<_$PremiumStateSendingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
