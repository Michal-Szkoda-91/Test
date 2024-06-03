// ignore: depend_on_referenced_packages
// ignore_for_file: invalid_annotation_target

import 'package:apparence_kit/core/data/entities/user_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';

part 'user.freezed.dart';

@freezed
sealed class User with _$User {
  const factory User.authenticated({
    required String email,
    String? name,
    String? id,
    DateTime? creationDate,
    DateTime? lastUpdateDate,
    String? avatarPath,
  }) = AuthenticatedUserData;

  const factory User.anonymous({String? id}) = AnonymousUserData;

  const factory User.loading() = LoadingUserData;

  const User._();

  factory User.fromEntity(UserEntity? entity) {
    try {
      if (entity == null) {
        return const User.anonymous();
      }
      if (entity.email == null) {
        return User.anonymous(id: entity.id);
      }
      return User.authenticated(
        id: entity.id,
        email: entity.email!,
        name: entity.name,
        avatarPath: entity.avatarPath,
        creationDate: entity.creationDate,
        lastUpdateDate: entity.lastUpdateDate,
      );
    } catch (e, trace) {
      Logger().e(e, stackTrace: trace);
      rethrow;
    }
  }

  String get idOrThrow => map(
        authenticated: (value) => value.id!,
        anonymous: (value) {
          if (value.id != null) {
            return value.id!;
          }
          throw "user is not connected";
        },
        loading: (_) => throw "user is not connected",
      );
}
