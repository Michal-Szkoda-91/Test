import 'dart:typed_data';

import 'package:apparence_kit/core/data/api/base_api_exceptions.dart';
{{#withStorage}}import 'package:apparence_kit/core/data/api/storage_api.dart';{{/withStorage}}
import 'package:apparence_kit/core/data/entities/upload_result.dart';
import 'package:apparence_kit/core/data/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final userApiProvider = Provider<UserApi>(
  (ref) => UserApi(
    client: FirebaseFirestore.instance,
    firebaseFunctions: FirebaseFunctions.instanceFor(region: 'europe-west1'), // TODO get region from environment
    {{#withStorage}}storageApi: ref.read(storageApiProvider),{{/withStorage}}
  ),
);

class UserApi {
  final FirebaseFirestore _client;
  final FirebaseFunctions _firebaseFunctions;
  final Logger _logger;
  {{#withStorage}}final StorageApi _storageApi;{{/withStorage}}

  UserApi({
    required FirebaseFirestore client,
    required FirebaseFunctions firebaseFunctions,
    {{#withStorage}}required StorageApi storageApi,{{/withStorage}}
  })  : _client = client,
        _logger = Logger(),
        _firebaseFunctions = firebaseFunctions{{#withStorage}},_storageApi = storageApi{{/withStorage}};

  CollectionReference<UserEntity?> get _collection =>
      _client.collection('users').withConverter(
            fromFirestore: (snapshot, _) {
              if (snapshot.exists) {
                return UserEntity.fromJson(snapshot.id, snapshot.data()!);
              }
              return null;
            },
            toFirestore: (data, _) => data!.toJson(),
          );

  Future<UserEntity?> get(String id) async {
    return _collection.doc(id).get().then((value) => value.data());
  }

  Future<void> update(UserEntity user) async {
    await _collection.doc(user.id).set(user);
  }

  Future<void> delete(String id) async {
    await _collection.doc(id).delete();
  }


  /// Delete the current user account
  /// As you can't delete a user authentification from the client
  /// we use a cloud function to delete the user
  /// This is required to publish any mobile app on the store (apple, google)
  /// User has to be able to delete their account
  Future<void> deleteMe() async {
    try {
      final callable = _firebaseFunctions.httpsCallable(
        'authFunctions-deleteUserAccount',
      );
      await callable.call();
    } catch (err, stacktrace) {
      _logger.e("delete user error $err", stackTrace: stacktrace);
      throw ApiError(message: "Error while deleting user");
    }
  }

  Future<void> create(UserEntity user) async {
    if (user.id == null) {
      throw Exception('User id cannot be null');
    }
    await _collection.doc(user.id).set(user);
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
        await _collection.doc(userId).update({
          "avatarPath": res.imagePublicUrl,
        });
      }
      yield res;
    }{{/withStorage}}{{^withStorage}}
    /// See the Storage doc to implement this method ./docs/storage.md
    throw UnimplementedError();{{/withStorage}}
  }
}
