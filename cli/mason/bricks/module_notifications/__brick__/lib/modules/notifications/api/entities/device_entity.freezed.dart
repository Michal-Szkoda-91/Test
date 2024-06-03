// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DeviceEntity _$DeviceEntityFromJson(Map<String, dynamic> json) {
  return DeviceEntityData.fromJson(json);
}

/// @nodoc
mixin _$DeviceEntity {
  String? get id => throw _privateConstructorUsedError;
  DateTime get creationDate => throw _privateConstructorUsedError;
  DateTime get lastUpdateDate => throw _privateConstructorUsedError;
  String get installationId => throw _privateConstructorUsedError;
  String get token => throw _privateConstructorUsedError;
  OperatingSystem get operatingSystem => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DeviceEntityCopyWith<DeviceEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceEntityCopyWith<$Res> {
  factory $DeviceEntityCopyWith(
          DeviceEntity value, $Res Function(DeviceEntity) then) =
      _$DeviceEntityCopyWithImpl<$Res, DeviceEntity>;
  @useResult
  $Res call(
      {String? id,
      DateTime creationDate,
      DateTime lastUpdateDate,
      String installationId,
      String token,
      OperatingSystem operatingSystem});
}

/// @nodoc
class _$DeviceEntityCopyWithImpl<$Res, $Val extends DeviceEntity>
    implements $DeviceEntityCopyWith<$Res> {
  _$DeviceEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? creationDate = null,
    Object? lastUpdateDate = null,
    Object? installationId = null,
    Object? token = null,
    Object? operatingSystem = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      creationDate: null == creationDate
          ? _value.creationDate
          : creationDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastUpdateDate: null == lastUpdateDate
          ? _value.lastUpdateDate
          : lastUpdateDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      installationId: null == installationId
          ? _value.installationId
          : installationId // ignore: cast_nullable_to_non_nullable
              as String,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      operatingSystem: null == operatingSystem
          ? _value.operatingSystem
          : operatingSystem // ignore: cast_nullable_to_non_nullable
              as OperatingSystem,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DeviceEntityDataImplCopyWith<$Res>
    implements $DeviceEntityCopyWith<$Res> {
  factory _$$DeviceEntityDataImplCopyWith(_$DeviceEntityDataImpl value,
          $Res Function(_$DeviceEntityDataImpl) then) =
      __$$DeviceEntityDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      DateTime creationDate,
      DateTime lastUpdateDate,
      String installationId,
      String token,
      OperatingSystem operatingSystem});
}

/// @nodoc
class __$$DeviceEntityDataImplCopyWithImpl<$Res>
    extends _$DeviceEntityCopyWithImpl<$Res, _$DeviceEntityDataImpl>
    implements _$$DeviceEntityDataImplCopyWith<$Res> {
  __$$DeviceEntityDataImplCopyWithImpl(_$DeviceEntityDataImpl _value,
      $Res Function(_$DeviceEntityDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? creationDate = null,
    Object? lastUpdateDate = null,
    Object? installationId = null,
    Object? token = null,
    Object? operatingSystem = null,
  }) {
    return _then(_$DeviceEntityDataImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      creationDate: null == creationDate
          ? _value.creationDate
          : creationDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastUpdateDate: null == lastUpdateDate
          ? _value.lastUpdateDate
          : lastUpdateDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      installationId: null == installationId
          ? _value.installationId
          : installationId // ignore: cast_nullable_to_non_nullable
              as String,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      operatingSystem: null == operatingSystem
          ? _value.operatingSystem
          : operatingSystem // ignore: cast_nullable_to_non_nullable
              as OperatingSystem,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeviceEntityDataImpl extends DeviceEntityData {
  const _$DeviceEntityDataImpl(
      {this.id,
      required this.creationDate,
      required this.lastUpdateDate,
      required this.installationId,
      required this.token,
      required this.operatingSystem})
      : super._();

  factory _$DeviceEntityDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeviceEntityDataImplFromJson(json);

  @override
  final String? id;
  @override
  final DateTime creationDate;
  @override
  final DateTime lastUpdateDate;
  @override
  final String installationId;
  @override
  final String token;
  @override
  final OperatingSystem operatingSystem;

  @override
  String toString() {
    return 'DeviceEntity(id: $id, creationDate: $creationDate, lastUpdateDate: $lastUpdateDate, installationId: $installationId, token: $token, operatingSystem: $operatingSystem)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeviceEntityDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.creationDate, creationDate) ||
                other.creationDate == creationDate) &&
            (identical(other.lastUpdateDate, lastUpdateDate) ||
                other.lastUpdateDate == lastUpdateDate) &&
            (identical(other.installationId, installationId) ||
                other.installationId == installationId) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.operatingSystem, operatingSystem) ||
                other.operatingSystem == operatingSystem));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, creationDate, lastUpdateDate,
      installationId, token, operatingSystem);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeviceEntityDataImplCopyWith<_$DeviceEntityDataImpl> get copyWith =>
      __$$DeviceEntityDataImplCopyWithImpl<_$DeviceEntityDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeviceEntityDataImplToJson(
      this,
    );
  }
}

abstract class DeviceEntityData extends DeviceEntity {
  const factory DeviceEntityData(
      {final String? id,
      required final DateTime creationDate,
      required final DateTime lastUpdateDate,
      required final String installationId,
      required final String token,
      required final OperatingSystem operatingSystem}) = _$DeviceEntityDataImpl;
  const DeviceEntityData._() : super._();

  factory DeviceEntityData.fromJson(Map<String, dynamic> json) =
      _$DeviceEntityDataImpl.fromJson;

  @override
  String? get id;
  @override
  DateTime get creationDate;
  @override
  DateTime get lastUpdateDate;
  @override
  String get installationId;
  @override
  String get token;
  @override
  OperatingSystem get operatingSystem;
  @override
  @JsonKey(ignore: true)
  _$$DeviceEntityDataImplCopyWith<_$DeviceEntityDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
