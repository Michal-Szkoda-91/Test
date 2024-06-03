import 'package:apparence_kit/core/data/entities/upload_result.dart';
import 'package:apparence_kit/core/data/repositories/user_repository.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../modules/authentication/data/api/user_api_fake.dart';
import '../api/storage_api_fake.dart';

void main() {
  UserRepository init() {
    final fakeStorageApi = FakeStorageApi();
    final fakeUserApi = FakeUserApi(storageApi: fakeStorageApi);
    return UserRepository(
      userApi: fakeUserApi,
    );
  }

  testWidgets('upload file and save avatar', (tester) async {
    await tester.runAsync(() async {
      final userRepository = init();

      final file = await rootBundle.load('assets/images/splashscreen.png');
      final bytes = file.buffer.asUint8List();
      // if you want to create an XFile from bytes
      // final xfile = XFile.fromData(bytes);

      final resultTask = userRepository.saveAvatar(
        userId: 'fake_user_id',
        data: bytes,
      );

      expect(
          resultTask,
          emitsAnyOf([
            UploadResultProgress(0.0),
            UploadResultCompleted(
              imagePath: 'imagePath',
              imagePublicUrl: 'imagePublicUrl',
            ),
          ]));
      await tester.pump();
      await tester.pumpAndSettle();
    });
  });
}
