import 'dart:io';

import 'package:apparence_cli/src/commands/generators/base_module_generator.dart';
import 'package:apparence_cli/src/templates/android_config_bundle.dart';
// ignore: library_prefixes
import 'package:path/path.dart' as Path;
import 'package:mason/mason.dart';

const kDefaultPackageName = 'io.apparence.apparence_kit';

class AndroidConfigGenerator extends BaseModuleGenerator {
  AndroidConfigGenerator({
    required super.generator,
    required super.outputPath,
    required super.setupResult,
  });

  @override
  Future<void> run() async {
    final androidConfigGenerator = await generator(androidConfigBundle);

    await androidConfigGenerator.generate(
      DirectoryGeneratorTarget(relativeDirectory("android")),
      vars: {
        'name': setupResult.appName,
        'withCamera': setupResult.cameraConfig != null,
      },
    );

    await editBuildGradle();
    await moveSources();
  }

  Future<void> editBuildGradle() async {
    logger.info('Editing android build.gradle file with bundleId');

    final buildGradleFile = File("$outputPath/android/app/build.gradle");
    if (buildGradleFile.existsSync() == false) {
      logger.warn('build.gradle file not found at ${buildGradleFile.path}');
      return;
    }
    final buildGradle = await buildGradleFile.readAsString();

    // replace default package name with the one provided by the user
    final newBuildGradle = buildGradle.replaceAll(
      kDefaultPackageName,
      setupResult.bundleId,
    );
    buildGradleFile.writeAsStringSync(newBuildGradle);
  }

  Future<void> moveSources() async {
    logger.info('Moving android sources to new package bundleId');
    final defaultBundleToPath = kDefaultPackageName.replaceAll('.', '/');
    final bundleToPath = setupResult.bundleId.replaceAll('.', '/');

    final sourceDirectory = Directory(
      "$outputPath/android/app/src/main/kotlin/$defaultBundleToPath",
    );
    final targetDirectory = Directory(
      "$outputPath/android/app/src/main/kotlin/$bundleToPath",
    );

    final sourceFiles = sourceDirectory.listSync();

    if (!targetDirectory.existsSync()) {
      targetDirectory.createSync(recursive: true);
    }
    for (final file in sourceFiles) {
      if (file is Directory) {
        continue;
      }
      final fileName = Path.basename(file.path);

      // final targetPath = Path.join(targetDirectory.path, fileName);
      final targetFile = File.fromUri(
        Uri.parse('${targetDirectory.path}/$fileName'),
      );
      file.renameSync(targetFile.path);
    }
    sourceDirectory.deleteSync(recursive: true);
    await updateMainKotlinPackage();
  }

  Future<void> updateMainKotlinPackage() async {
    final bundleToPath = setupResult.bundleId.replaceAll('.', '/');
    final mainKtFile = File(
        "$outputPath/android/app/src/main/kotlin/$bundleToPath/MainActivity.kt");
    if (mainKtFile.existsSync() == false) {
      logger.warn('MainActivity.kt file not found at ${mainKtFile.path}');
      return;
    }
    final mainKtContent = await mainKtFile.readAsString();
    final newFileContent = mainKtContent.replaceAll(
      kDefaultPackageName,
      setupResult.bundleId,
    );
    mainKtFile.writeAsStringSync(newFileContent);
  }
}
