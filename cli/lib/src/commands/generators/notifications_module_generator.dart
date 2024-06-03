import 'package:apparence_cli/src/commands/generators/base_module_generator.dart';
import 'package:apparence_cli/src/commands/models/backend.dart';
import 'package:apparence_cli/src/process_runner.dart';
import 'package:apparence_cli/src/templates/module_notifications_bundle.dart';
import 'package:mason/mason.dart';

class NotificationsModuleGenerator extends BaseModuleGenerator {
  final bool skipInstall;

  NotificationsModuleGenerator({
    required super.generator,
    required super.outputPath,
    required super.setupResult,
    this.skipInstall = false,
  });

  @override
  Future<void> run() async {
    if (!skipInstall) {
      await installDependencies([
        'firebase_app_installations',
        'firebase_core',
        'firebase_messaging',
        'flutter_local_notifications',
      ]);
    }

    final notificationsGenerator = await generator(moduleNotificationsBundle);

    await notificationsGenerator.generate(
      DirectoryGeneratorTarget(relativeDirectory("")),
      vars: {
        'webCompat': setupResult.webCompat,
        'firebase': setupResult.backendProvider == BackendProvider.firebase,
        'supabase': setupResult.backendProvider == BackendProvider.supabase,
        'http_client': setupResult.backendProvider == BackendProvider.restApi,
      },
    );

    await renameProviderApi(
      'lib/modules/notifications/api',
      'device_api.dart',
    );
    await renameProviderApi(
      'lib/modules/notifications/api',
      'notifications_api.dart',
    );

    await renameProviderApi(
      'lib/modules/notifications/api/entities',
      'device_entity.dart',
    );
    await renameProviderApi(
      'lib/modules/notifications/api/entities',
      'notifications_entity.dart',
    );

    await setupIosInfoPlist();
  }

  Future<void> setupIosInfoPlist() async {
    try {
      await PlUtilRunner([
        '-replace',
        'UIBackgroundModes',
        '-array',
        'ios/Runner/Info.plist'
      ]).run();
      await PlUtilRunner([
        '-insert',
        'UIBackgroundModes',
        '-string',
        'fetch',
        '-append',
        'ios/Runner/Info.plist'
      ]).run();
      await PlUtilRunner([
        '-insert',
        'UIBackgroundModes',
        '-string',
        'remote-notification',
        '-append',
        'ios/Runner/Info.plist'
      ]).run();
    } catch (e) {
      logger.err('Failed to add iOS info.plist config: $e');
      logger.err('Please add the following to your info.plist file:');
      logger.err('''
      <key>UIBackgroundModes</key>
      <array>
        <string>fetch</string>
        <string>remote-notification</string>
      </array>
      ''');
    }
  }
}
