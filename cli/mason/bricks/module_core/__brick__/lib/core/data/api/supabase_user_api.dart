import 'dart:typed_data';

import 'package:apparence_kit/core/data/api/base_api_exceptions.dart';
{{#withStorage}}import 'package:apparence_kit/core/data/api/storage_api.dart';{{/withStorage}}
import 'package:apparence_kit/core/data/entities/upload_result.dart';
import 'package:apparence_kit/core/data/entities/user_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final userApiProvider = Provider<UserApi>(
  (ref) => UserApi(
    client: Supabase.instance.client,
    {{#withStorage}}storageApi: ref.read(storageApiProvider),{{/withStorage}}
  ),
);

class UserApi {
  final SupabaseClient _client;
  {{#withStorage}}final StorageApi _storageApi;{{/withStorage}}

  UserApi({
    required SupabaseClient client,
    {{#withStorage}}required StorageApi storageApi,{{/withStorage}}
  }) : _client = client{{#withStorage}},_storageApi = storageApi{{/withStorage}};

  Future<UserEntity?> get(String id) async {
    try {
      final res = await _client
          .from('users') //
          .select()
          .eq('id', id);
      if (res.isEmpty) {
        return null;
      }
      return UserEntity.fromJson(res.first);
    } catch (e, stacktrace) {
      throw ApiError(
        code: 0,
        message: '$e: $stacktrace',
      );
    }
  }

  Future<void> update(UserEntity user) async {
    try {
      await _client
          .from('users') //
          .update(user.toJson())
          .eq('id', user.id!);
    } catch (e, stacktrace) {
      throw ApiError(
        code: 0,
        message: '$e: $stacktrace',
      );
    }
  }

  Future<void> delete(String userId) async {
    try {
      await _client
          .from('users') //
          .delete()
          .eq('id', userId);
    } catch (e, stacktrace) {
      throw ApiError(
        code: 0,
        message: '$e: $stacktrace',
      );
    }
  }

  Future<void> deleteMe() async {
    try {
      await _client
          .from('users')
          .delete()
          .eq('id', _client.auth.currentUser!.id);
    } catch (e, stacktrace) {
      throw ApiError(
        code: 0,
        message: '$e: $stacktrace',
      );
    }
  }

  Future<void> create(UserEntity user) async {
    try {
      await _client
          .from('users') //
          .insert([user.toJson()]);
    } catch (e, stacktrace) {
      throw ApiError(
        code: 0,
        message: '$e: $stacktrace',
      );
    }
  }

  Stream<UploadResult> updateAvatar(
    String userId,
    Uint8List data,
  ) async* {
    {{#withStorage}}final task = _storageApi.uploadData(
      data,
      'users/$userId/avatar',
      'thumb.jpg',
      mimeType: 'image/jpg',
    );
    await for (final res in task) {
      if (res case UploadResultCompleted()) {
        await _client
            .from('users') //
            .update({'avatarPath': res.imagePublicUrl}) //
            .eq('id', userId);
      }
      yield res;
    }{{/withStorage}}{{^withStorage}}
    /// See the Storage doc to implement this method ./docs/storage.md
    throw UnimplementedError();{{/withStorage}}
  }
}
