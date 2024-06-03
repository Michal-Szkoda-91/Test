{{#firestore}}
import 'package:apparence_kit/modules/{{name.snakeCase()}}/api/entities/{{api_name.snakeCase()}}_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final {{api_name.camelCase()}}ApiProvider = Provider<{{api_name.pascalCase()}}Api>(
  (ref) => {{api_name.pascalCase()}}Api(
    client: FirebaseFirestore.instance,
  ),
);

class {{api_name.pascalCase()}}Api {
  final FirebaseFirestore _client;

  {{api_name.pascalCase()}}Api({
    required FirebaseFirestore client,
  }) : _client = client;

  CollectionReference<{{api_name.pascalCase()}}Entity?> _collection() => _client
      .collection('{{api_name.snakeCase()}}')
      .withConverter(
        fromFirestore: (snapshot, _) {
          if (snapshot.exists) {
            return {{api_name.pascalCase()}}Entity.fromJson(snapshot.id, snapshot.data()!);
          }
          return null;
        },
        toFirestore: (data, _) => data!.toJson(),
      );

  Future<{{api_name.pascalCase()}}Entity> create({{api_name.pascalCase()}}Entity {{api_name.camelCase()}}) async {
    final doc = await _collection().add({{api_name.camelCase()}});
    return {{api_name.camelCase()}}.copyWith(id: doc.id);
  }

  Future<{{api_name.pascalCase()}}Entity?> get(String id) {
    return _collection().doc(id).get().then((value) => value.data());
  }

  Future<List<{{api_name.pascalCase()}}Entity>> getAll(String id) {
    return _collection() //
        .get() //
        .then((value) => value.docs.map((e) => e.data()).toList().cast());
  }

  Future<void> clear(String userId) async {
    final res = await _collection().get();
    final batch = _client.batch();
    for (final item in res.docs) {
      batch.delete(item.reference);
    }
    await batch.commit();
  }


}
{{/firestore}}
{{#http_client}}
import 'package:apparence_kit/core/data/api/base_api_exceptions.dart';
import 'package:apparence_kit/core/data/api/http_client.dart';
import 'package:apparence_kit/modules/{{name.snakeCase()}}/api/entities/{{api_name.snakeCase()}}_entity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final {{api_name.camelCase()}}ApiProvider = Provider<{{api_name.pascalCase()}}Api>(
  (ref) => {{api_name.pascalCase()}}Api(
    client: ref.read(httpClientProvider),
  ),
);

class {{api_name.pascalCase()}}Api {
  final HttpClient _client;

  {{api_name.pascalCase()}}Api({
    required HttpClient client,
  }) : _client = client;

  Future<{{api_name.pascalCase()}}Entity?> get(String id) async {
    try {
      final response = await _client.get(
        '/{{api_name.snakeCase()}}/$id',
      );
      if (response.data == null) {
        return null;
      }
      return {{api_name.pascalCase()}}Entity.fromJson(response.data! as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiError.fromDioException(e);
    } catch (e, stacktrace) {
      throw ApiError(
        code: 0,
        message: '$e: $stacktrace',
      );
    }
  }

  Future<{{api_name.pascalCase()}}Entity> create({{api_name.pascalCase()}}Entity {{api_name.camelCase()}}) async {
    try {
      final response = await _client.post(
        '/{{api_name.snakeCase()}}',
        data: {{api_name.camelCase()}}.toJson(),
      );
      return {{api_name.pascalCase()}}Entity.fromJson(response.data! as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiError.fromDioException(e);
    } catch (e, stacktrace) {
      throw ApiError(
        code: 0,
        message: '$e: $stacktrace',
      );
    }
  }

  Future<void> update({{api_name.pascalCase()}}Entity {{api_name.camelCase()}}) async {
    try {
      final _ = await _client.put(
        '/{{api_name.snakeCase()}}/${{{api_name.camelCase()}}.id}',
        data: {{api_name.camelCase()}}.toJson(),
      );
    } on DioException catch (e) {
      throw ApiError.fromDioException(e);
    } catch (e, stacktrace) {
      throw ApiError(
        code: 0,
        message: '$e: $stacktrace',
      );
    }
  }
}
{{/http_client}}