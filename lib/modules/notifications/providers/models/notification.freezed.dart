// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Notification {
  String? get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get body => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get readAt => throw _privateConstructorUsedError;
  LocalNotifier? get notifier => throw _privateConstructorUsedError;
  NotificationSettings? get notifierSettings =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String? id,
            String? title,
            String? body,
            DateTime createdAt,
            DateTime? readAt,
            LocalNotifier? notifier,
            NotificationSettings? notifierSettings)
        withData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String? id,
            String? title,
            String? body,
            DateTime createdAt,
            DateTime? readAt,
            LocalNotifier? notifier,
            NotificationSettings? notifierSettings)?
        withData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String? id,
            String? title,
            String? body,
            DateTime createdAt,
            DateTime? readAt,
            LocalNotifier? notifier,
            NotificationSettings? notifierSettings)?
        withData,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NotificationData value) withData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NotificationData value)? withData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotificationData value)? withData,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NotificationCopyWith<Notification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationCopyWith<$Res> {
  factory $NotificationCopyWith(
          Notification value, $Res Function(Notification) then) =
      _$NotificationCopyWithImpl<$Res, Notification>;
  @useResult
  $Res call(
      {String? id,
      String? title,
      String? body,
      DateTime createdAt,
      DateTime? readAt,
      LocalNotifier? notifier,
      NotificationSettings? notifierSettings});
}

/// @nodoc
class _$NotificationCopyWithImpl<$Res, $Val extends Notification>
    implements $NotificationCopyWith<$Res> {
  _$NotificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? body = freezed,
    Object? createdAt = null,
    Object? readAt = freezed,
    Object? notifier = freezed,
    Object? notifierSettings = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      body: freezed == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      readAt: freezed == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      notifier: freezed == notifier
          ? _value.notifier
          : notifier // ignore: cast_nullable_to_non_nullable
              as LocalNotifier?,
      notifierSettings: freezed == notifierSettings
          ? _value.notifierSettings
          : notifierSettings // ignore: cast_nullable_to_non_nullable
              as NotificationSettings?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationDataImplCopyWith<$Res>
    implements $NotificationCopyWith<$Res> {
  factory _$$NotificationDataImplCopyWith(_$NotificationDataImpl value,
          $Res Function(_$NotificationDataImpl) then) =
      __$$NotificationDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? title,
      String? body,
      DateTime createdAt,
      DateTime? readAt,
      LocalNotifier? notifier,
      NotificationSettings? notifierSettings});
}

/// @nodoc
class __$$NotificationDataImplCopyWithImpl<$Res>
    extends _$NotificationCopyWithImpl<$Res, _$NotificationDataImpl>
    implements _$$NotificationDataImplCopyWith<$Res> {
  __$$NotificationDataImplCopyWithImpl(_$NotificationDataImpl _value,
      $Res Function(_$NotificationDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? body = freezed,
    Object? createdAt = null,
    Object? readAt = freezed,
    Object? notifier = freezed,
    Object? notifierSettings = freezed,
  }) {
    return _then(_$NotificationDataImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      body: freezed == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      readAt: freezed == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      notifier: freezed == notifier
          ? _value.notifier
          : notifier // ignore: cast_nullable_to_non_nullable
              as LocalNotifier?,
      notifierSettings: freezed == notifierSettings
          ? _value.notifierSettings
          : notifierSettings // ignore: cast_nullable_to_non_nullable
              as NotificationSettings?,
    ));
  }
}

/// @nodoc

class _$NotificationDataImpl extends NotificationData {
  const _$NotificationDataImpl(
      {this.id,
      this.title,
      this.body,
      required this.createdAt,
      this.readAt,
      this.notifier,
      this.notifierSettings})
      : super._();

  @override
  final String? id;
  @override
  final String? title;
  @override
  final String? body;
  @override
  final DateTime createdAt;
  @override
  final DateTime? readAt;
  @override
  final LocalNotifier? notifier;
  @override
  final NotificationSettings? notifierSettings;

  @override
  String toString() {
    return 'Notification.withData(id: $id, title: $title, body: $body, createdAt: $createdAt, readAt: $readAt, notifier: $notifier, notifierSettings: $notifierSettings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.readAt, readAt) || other.readAt == readAt) &&
            (identical(other.notifier, notifier) ||
                other.notifier == notifier) &&
            (identical(other.notifierSettings, notifierSettings) ||
                other.notifierSettings == notifierSettings));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, title, body, createdAt,
      readAt, notifier, notifierSettings);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationDataImplCopyWith<_$NotificationDataImpl> get copyWith =>
      __$$NotificationDataImplCopyWithImpl<_$NotificationDataImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String? id,
            String? title,
            String? body,
            DateTime createdAt,
            DateTime? readAt,
            LocalNotifier? notifier,
            NotificationSettings? notifierSettings)
        withData,
  }) {
    return withData(
        id, title, body, createdAt, readAt, notifier, notifierSettings);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String? id,
            String? title,
            String? body,
            DateTime createdAt,
            DateTime? readAt,
            LocalNotifier? notifier,
            NotificationSettings? notifierSettings)?
        withData,
  }) {
    return withData?.call(
        id, title, body, createdAt, readAt, notifier, notifierSettings);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String? id,
            String? title,
            String? body,
            DateTime createdAt,
            DateTime? readAt,
            LocalNotifier? notifier,
            NotificationSettings? notifierSettings)?
        withData,
    required TResult orElse(),
  }) {
    if (withData != null) {
      return withData(
          id, title, body, createdAt, readAt, notifier, notifierSettings);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NotificationData value) withData,
  }) {
    return withData(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NotificationData value)? withData,
  }) {
    return withData?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotificationData value)? withData,
    required TResult orElse(),
  }) {
    if (withData != null) {
      return withData(this);
    }
    return orElse();
  }
}

abstract class NotificationData extends Notification {
  const factory NotificationData(
      {final String? id,
      final String? title,
      final String? body,
      required final DateTime createdAt,
      final DateTime? readAt,
      final LocalNotifier? notifier,
      final NotificationSettings? notifierSettings}) = _$NotificationDataImpl;
  const NotificationData._() : super._();

  @override
  String? get id;
  @override
  String? get title;
  @override
  String? get body;
  @override
  DateTime get createdAt;
  @override
  DateTime? get readAt;
  @override
  LocalNotifier? get notifier;
  @override
  NotificationSettings? get notifierSettings;
  @override
  @JsonKey(ignore: true)
  _$$NotificationDataImplCopyWith<_$NotificationDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
