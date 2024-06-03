// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ads_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AdState {
  DateTime? get lastAdShown => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AdStateCopyWith<AdState> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdStateCopyWith<$Res> {
  factory $AdStateCopyWith(AdState value, $Res Function(AdState) then) =
      _$AdStateCopyWithImpl<$Res, AdState>;
  @useResult
  $Res call({DateTime? lastAdShown});
}

/// @nodoc
class _$AdStateCopyWithImpl<$Res, $Val extends AdState>
    implements $AdStateCopyWith<$Res> {
  _$AdStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastAdShown = freezed,
  }) {
    return _then(_value.copyWith(
      lastAdShown: freezed == lastAdShown
          ? _value.lastAdShown
          : lastAdShown // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AdStateImplCopyWith<$Res> implements $AdStateCopyWith<$Res> {
  factory _$$AdStateImplCopyWith(
          _$AdStateImpl value, $Res Function(_$AdStateImpl) then) =
      __$$AdStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime? lastAdShown});
}

/// @nodoc
class __$$AdStateImplCopyWithImpl<$Res>
    extends _$AdStateCopyWithImpl<$Res, _$AdStateImpl>
    implements _$$AdStateImplCopyWith<$Res> {
  __$$AdStateImplCopyWithImpl(
      _$AdStateImpl _value, $Res Function(_$AdStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastAdShown = freezed,
  }) {
    return _then(_$AdStateImpl(
      lastAdShown: freezed == lastAdShown
          ? _value.lastAdShown
          : lastAdShown // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$AdStateImpl extends _AdState {
  const _$AdStateImpl({this.lastAdShown}) : super._();

  @override
  final DateTime? lastAdShown;

  @override
  String toString() {
    return 'AdState(lastAdShown: $lastAdShown)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdStateImpl &&
            (identical(other.lastAdShown, lastAdShown) ||
                other.lastAdShown == lastAdShown));
  }

  @override
  int get hashCode => Object.hash(runtimeType, lastAdShown);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AdStateImplCopyWith<_$AdStateImpl> get copyWith =>
      __$$AdStateImplCopyWithImpl<_$AdStateImpl>(this, _$identity);
}

abstract class _AdState extends AdState {
  const factory _AdState({final DateTime? lastAdShown}) = _$AdStateImpl;
  const _AdState._() : super._();

  @override
  DateTime? get lastAdShown;
  @override
  @JsonKey(ignore: true)
  _$$AdStateImplCopyWith<_$AdStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
