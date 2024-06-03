import 'dart:io';

import 'package:apparence_cli/src/commands/generators/base_module_generator.dart';
import 'package:apparence_cli/src/process_runner.dart';

const kDefaultPackageName = 'io.apparence.apparenceKit';

class IosConfigGenerator extends BaseModuleGenerator {
  IosConfigGenerator({
    required super.generator,
    required super.outputPath,
    required super.setupResult,
  });

  @override
  Future<void> run() async {
    try {
      await PlUtilRunner([
        '-replace',
        'CFBundleDisplayName',
        '-string',
        setupResult.appName,
        'ios/Runner/Info.plist'
      ]).run();
      await PlUtilRunner([
        '-replace',
        'CFBundleName',
        '-string',
        setupResult.bundleId.split('.').last,
        'ios/Runner/Info.plist'
      ]).run();

      await changeBundleId();
      logger.info('iOS configuration updated with your bundleId and App name.');
    } catch (e) {
      logger.err(
        'Failed to update iOS configuration with your bundleId and App name.',
      );
      logger.err(
        'Please change it manually with a mac and up to date XCode.',
      );
    }
  }

  Future<void> changeBundleId() async {
    try {
      final projectFile =
          File("$outputPath/ios/Runner.xcodeproj/project.pbxproj");
      if (projectFile.existsSync() == false) {
        logger.warn('iOS project file not found at ${projectFile.path}');
        return;
      }
      final projectContent = await projectFile.readAsString();
      final newContent = projectContent.replaceAll(
        kDefaultPackageName,
        setupResult.bundleId,
      );
      projectFile.writeAsStringSync(newContent);

      logger.info('iOS bundleId updated with your bundleId.');
    } catch (e) {
      logger.err('Failed to update iOS bundleId with your bundleId.');
      logger.err(
        'Please change it manually with a mac and up to date XCode.',
      );
    }
  }
}
