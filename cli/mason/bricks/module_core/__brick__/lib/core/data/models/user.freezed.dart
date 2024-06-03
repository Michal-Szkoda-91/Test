// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$User {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String email,
            String? name,
            String? id,
            DateTime? creationDate,
            DateTime? lastUpdateDate,
            String? avatarPath)
        authenticated,
    required TResult Function() anonymous,
    required TResult Function() loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String email,
            String? name,
            String? id,
            DateTime? creationDate,
            DateTime? lastUpdateDate,
            String? avatarPath)?
        authenticated,
    TResult? Function()? anonymous,
    TResult? Function()? loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String email,
            String? name,
            String? id,
            DateTime? creationDate,
            DateTime? lastUpdateDate,
            String? avatarPath)?
        authenticated,
    TResult Function()? anonymous,
    TResult Function()? loading,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthenticatedUserData value) authenticated,
    required TResult Function(AnonymousUserData value) anonymous,
    required TResult Function(LoadingUserData value) loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthenticatedUserData value)? authenticated,
    TResult? Function(AnonymousUserData value)? anonymous,
    TResult? Function(LoadingUserData value)? loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthenticatedUserData value)? authenticated,
    TResult Function(AnonymousUserData value)? anonymous,
    TResult Function(LoadingUserData value)? loading,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$AuthenticatedUserDataImplCopyWith<$Res> {
  factory _$$AuthenticatedUserDataImplCopyWith(
          _$AuthenticatedUserDataImpl value,
          $Res Function(_$AuthenticatedUserDataImpl) then) =
      __$$AuthenticatedUserDataImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String email,
      String? name,
      String? id,
      DateTime? creationDate,
      DateTime? lastUpdateDate,
      String? avatarPath});
}

/// @nodoc
class __$$AuthenticatedUserDataImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$AuthenticatedUserDataImpl>
    implements _$$AuthenticatedUserDataImplCopyWith<$Res> {
  __$$AuthenticatedUserDataImplCopyWithImpl(_$AuthenticatedUserDataImpl _value,
      $Res Function(_$AuthenticatedUserDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? name = freezed,
    Object? id = freezed,
    Object? creationDate = freezed,
    Object? lastUpdateDate = freezed,
    Object? avatarPath = freezed,
  }) {
    return _then(_$AuthenticatedUserDataImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      creationDate: freezed == creationDate
          ? _value.creationDate
          : creationDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastUpdateDate: freezed == lastUpdateDate
          ? _value.lastUpdateDate
          : lastUpdateDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      avatarPath: freezed == avatarPath
          ? _value.avatarPath
          : avatarPath // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AuthenticatedUserDataImpl extends AuthenticatedUserData {
  const _$AuthenticatedUserDataImpl(
      {required this.email,
      this.name,
      this.id,
      this.creationDate,
      this.lastUpdateDate,
      this.avatarPath})
      : super._();

  @override
  final String email;
  @override
  final String? name;
  @override
  final String? id;
  @override
  final DateTime? creationDate;
  @override
  final DateTime? lastUpdateDate;
  @override
  final String? avatarPath;

  @override
  String toString() {
    return 'User.authenticated(email: $email, name: $name, id: $id, creationDate: $creationDate, lastUpdateDate: $lastUpdateDate, avatarPath: $avatarPath)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticatedUserDataImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.creationDate, creationDate) ||
                other.creationDate == creationDate) &&
            (identical(other.lastUpdateDate, lastUpdateDate) ||
                other.lastUpdateDate == lastUpdateDate) &&
            (identical(other.avatarPath, avatarPath) ||
                other.avatarPath == avatarPath));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, email, name, id, creationDate, lastUpdateDate, avatarPath);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticatedUserDataImplCopyWith<_$AuthenticatedUserDataImpl>
      get copyWith => __$$AuthenticatedUserDataImplCopyWithImpl<
          _$AuthenticatedUserDataImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String email,
            String? name,
            String? id,
            DateTime? creationDate,
            DateTime? lastUpdateDate,
            String? avatarPath)
        authenticated,
    required TResult Function() anonymous,
    required TResult Function() loading,
  }) {
    return authenticated(
        email, name, id, creationDate, lastUpdateDate, avatarPath);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String email,
            String? name,
            String? id,
            DateTime? creationDate,
            DateTime? lastUpdateDate,
            String? avatarPath)?
        authenticated,
    TResult? Function()? anonymous,
    TResult? Function()? loading,
  }) {
    return authenticated?.call(
        email, name, id, creationDate, lastUpdateDate, avatarPath);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String email,
            String? name,
            String? id,
            DateTime? creationDate,
            DateTime? lastUpdateDate,
            String? avatarPath)?
        authenticated,
    TResult Function()? anonymous,
    TResult Function()? loading,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(
          email, name, id, creationDate, lastUpdateDate, avatarPath);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthenticatedUserData value) authenticated,
    required TResult Function(AnonymousUserData value) anonymous,
    required TResult Function(LoadingUserData value) loading,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthenticatedUserData value)? authenticated,
    TResult? Function(AnonymousUserData value)? anonymous,
    TResult? Function(LoadingUserData value)? loading,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthenticatedUserData value)? authenticated,
    TResult Function(AnonymousUserData value)? anonymous,
    TResult Function(LoadingUserData value)? loading,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class AuthenticatedUserData extends User {
  const factory AuthenticatedUserData(
      {required final String email,
      final String? name,
      final String? id,
      final DateTime? creationDate,
      final DateTime? lastUpdateDate,
      final String? avatarPath}) = _$AuthenticatedUserDataImpl;
  const AuthenticatedUserData._() : super._();

  String get email;
  String? get name;
  String? get id;
  DateTime? get creationDate;
  DateTime? get lastUpdateDate;
  String? get avatarPath;
  @JsonKey(ignore: true)
  _$$AuthenticatedUserDataImplCopyWith<_$AuthenticatedUserDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AnonymousUserDataImplCopyWith<$Res> {
  factory _$$AnonymousUserDataImplCopyWith(_$AnonymousUserDataImpl value,
          $Res Function(_$AnonymousUserDataImpl) then) =
      __$$AnonymousUserDataImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AnonymousUserDataImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$AnonymousUserDataImpl>
    implements _$$AnonymousUserDataImplCopyWith<$Res> {
  __$$AnonymousUserDataImplCopyWithImpl(_$AnonymousUserDataImpl _value,
      $Res Function(_$AnonymousUserDataImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AnonymousUserDataImpl extends AnonymousUserData {
  const _$AnonymousUserDataImpl() : super._();

  @override
  String toString() {
    return 'User.anonymous()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AnonymousUserDataImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String email,
            String? name,
            String? id,
            DateTime? creationDate,
            DateTime? lastUpdateDate,
            String? avatarPath)
        authenticated,
    required TResult Function() anonymous,
    required TResult Function() loading,
  }) {
    return anonymous();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String email,
            String? name,
            String? id,
            DateTime? creationDate,
            DateTime? lastUpdateDate,
            String? avatarPath)?
        authenticated,
    TResult? Function()? anonymous,
    TResult? Function()? loading,
  }) {
    return anonymous?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String email,
            String? name,
            String? id,
            DateTime? creationDate,
            DateTime? lastUpdateDate,
            String? avatarPath)?
        authenticated,
    TResult Function()? anonymous,
    TResult Function()? loading,
    required TResult orElse(),
  }) {
    if (anonymous != null) {
      return anonymous();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthenticatedUserData value) authenticated,
    required TResult Function(AnonymousUserData value) anonymous,
    required TResult Function(LoadingUserData value) loading,
  }) {
    return anonymous(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthenticatedUserData value)? authenticated,
    TResult? Function(AnonymousUserData value)? anonymous,
    TResult? Function(LoadingUserData value)? loading,
  }) {
    return anonymous?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthenticatedUserData value)? authenticated,
    TResult Function(AnonymousUserData value)? anonymous,
    TResult Function(LoadingUserData value)? loading,
    required TResult orElse(),
  }) {
    if (anonymous != null) {
      return anonymous(this);
    }
    return orElse();
  }
}

abstract class AnonymousUserData extends User {
  const factory AnonymousUserData() = _$AnonymousUserDataImpl;
  const AnonymousUserData._() : super._();
}

/// @nodoc
abstract class _$$LoadingUserDataImplCopyWith<$Res> {
  factory _$$LoadingUserDataImplCopyWith(_$LoadingUserDataImpl value,
          $Res Function(_$LoadingUserDataImpl) then) =
      __$$LoadingUserDataImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingUserDataImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$LoadingUserDataImpl>
    implements _$$LoadingUserDataImplCopyWith<$Res> {
  __$$LoadingUserDataImplCopyWithImpl(
      _$LoadingUserDataImpl _value, $Res Function(_$LoadingUserDataImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadingUserDataImpl extends LoadingUserData {
  const _$LoadingUserDataImpl() : super._();

  @override
  String toString() {
    return 'User.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingUserDataImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String email,
            String? name,
            String? id,
            DateTime? creationDate,
            DateTime? lastUpdateDate,
            String? avatarPath)
        authenticated,
    required TResult Function() anonymous,
    required TResult Function() loading,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String email,
            String? name,
            String? id,
            DateTime? creationDate,
            DateTime? lastUpdateDate,
            String? avatarPath)?
        authenticated,
    TResult? Function()? anonymous,
    TResult? Function()? loading,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String email,
            String? name,
            String? id,
            DateTime? creationDate,
            DateTime? lastUpdateDate,
            String? avatarPath)?
        authenticated,
    TResult Function()? anonymous,
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
    required TResult Function(AuthenticatedUserData value) authenticated,
    required TResult Function(AnonymousUserData value) anonymous,
    required TResult Function(LoadingUserData value) loading,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthenticatedUserData value)? authenticated,
    TResult? Function(AnonymousUserData value)? anonymous,
    TResult? Function(LoadingUserData value)? loading,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthenticatedUserData value)? authenticated,
    TResult Function(AnonymousUserData value)? anonymous,
    TResult Function(LoadingUserData value)? loading,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class LoadingUserData extends User {
  const factory LoadingUserData() = _$LoadingUserDataImpl;
  const LoadingUserData._() : super._();
}
