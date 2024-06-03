import 'dart:convert';
import 'dart:io';

import 'package:apparence_cli/src/commands/generators/base_module_generator.dart';
import 'package:apparence_cli/src/commands/models/backend.dart';
import 'package:apparence_cli/src/commands/models/setup_config.dart';
import 'package:apparence_cli/src/templates/main_bundle.dart';
import 'package:apparence_cli/src/templates/module_core_bundle.dart';
import 'package:apparence_cli/src/templates/module_home_bundle.dart';
import 'package:apparence_cli/src/templates/module_settings_bundle.dart';
import 'package:apparence_cli/src/templates/router_bundle.dart';
import 'package:apparence_cli/src/templates/test_utils_bundle.dart';
import 'package:mason/mason.dart';
import 'package:yaml_edit/yaml_edit.dart';

class CoreModuleGenerator extends BaseModuleGenerator {
  CoreModuleGenerator({
    required super.generator,
    required super.outputPath,
    required super.setupResult,
  });

  @override
  Future<void> run() async {
    await writePubspec();

    final coreGenerator = await generator(moduleCoreBundle);
    final routerGenerator = await generator(routerBundle);
    final mainGenerator = await generator(mainBundle);
    final homeGenerator = await generator(moduleHomeBundle);
    final settingsGenerator = await generator(moduleSettingsBundle);
    final testUtilsGenerator = await generator(testUtilsBundle);

    await coreGenerator.generate(
      DirectoryGeneratorTarget(relativeDirectory("")),
      vars: {
        'withStorage': setupResult.storageProvider != null,
        'supabase': setupResult.backendProvider == BackendProvider.supabase,
        'firebase': setupResult.backendProvider == BackendProvider.firebase,
        'http_client': setupResult.backendProvider == BackendProvider.restApi,
        'anonymous_auth': setupResult.anonymousSignup,
        'translations': setupResult.internationalization,
      },
    );

    await mainGenerator.generate(
      DirectoryGeneratorTarget(relativeDirectory("lib")),
      vars: {
        'slang': setupResult.internationalization,
        'sentry': setupResult.useSentry,
        'remoteConfig': setupResult.remoteConfigProvider != null,
        'supabase': setupResult.backendProvider == BackendProvider.supabase,
        'analytics': setupResult.analyticsProvider != null,
      },
    );
    await routerGenerator.generate(
      DirectoryGeneratorTarget(relativeDirectory("lib")),
      vars: {
        'withOnboarding': setupResult.withOnboarding,
        'firebaseAnalytics':
            setupResult.analyticsProvider == AnalyticsProviders.firebase,
        'mixpanel':
            setupResult.analyticsProvider == AnalyticsProviders.mixpanel,
      },
    );
    await settingsGenerator.generate(
      DirectoryGeneratorTarget(relativeDirectory("")),
      vars: {
        'supabase': setupResult.backendProvider == BackendProvider.supabase,
        'firebase': setupResult.backendProvider == BackendProvider.firebase,
        'http_client': setupResult.backendProvider == BackendProvider.restApi,
        'withPicker': setupResult.storageProvider != null,
      },
    );

    await homeGenerator.generate(
      DirectoryGeneratorTarget(relativeDirectory("")),
      vars: {
        'supabase': setupResult.backendProvider == BackendProvider.supabase,
        'firebase': setupResult.backendProvider == BackendProvider.firebase,
        'http_client': setupResult.backendProvider == BackendProvider.restApi,
      },
    );

    await testUtilsGenerator.generate(
      DirectoryGeneratorTarget(relativeDirectory("test")),
      vars: {
        'remoteConfig': setupResult.remoteConfigProvider != null,
        'analytics': setupResult.analyticsProvider != null,
      },
    );

    if (setupResult.backendProvider != BackendProvider.firebase) {
      File("lib/core/data/entities/json_converters.dart").deleteSync();
    }

    // remove other backend providers api
    await renameProviderApi(
      'lib/core/data/api',
      'user_api.dart',
    );
    await renameProviderApi(
      'lib/core/data/api',
      'storage_api.dart',
    );
    // remove other backend providers entities
    await renameProviderApi(
      'lib/core/data/entities',
      'user_entity.dart',
    );

    // remove basic test file
    final flutterGeneratedTestFile = File("test/widget_test.dart");
    if (flutterGeneratedTestFile.existsSync()) {
      flutterGeneratedTestFile.deleteSync();
    }

    await install();
  }

  Future<void> install() async {
    await installDependencies([
      'animations',
      'another_flushbar',
      'bart',
      'better_skeleton',
      'device_info_plus',
      'flutter_animate',
      'flutter_native_splash:2.3.10',
      'flutter_riverpod',
      'flutter_secure_storage',
      'freezed_annotation',
      'go_router',
      'intl',
      'google_fonts',
      'in_app_review',
      'jiffy',
      'json_annotation',
      'logger',
      'riverpod_annotation',
      'shared_preferences',
      'universal_io',
      'url_launcher',
    ]);

    const httpDependencies = ['dio'];
    await installDependencies(httpDependencies);

    const storageDependencies = [
      'image_picker',
      'image',
      'path_provider',
    ];

    switch (setupResult.backendProvider) {
      case BackendProvider.supabase:
        await installDependencies(['supabase_flutter']);
        break;
      case BackendProvider.firebase:
        await installDependencies([
          'firebase_core',
          'firebase_auth',
          'cloud_firestore',
          'cloud_functions',
        ]);
        if (setupResult.storageProvider != null) {
          await installDependencies(['firebase_storage']);
        }
        break;
      case BackendProvider.restApi:
        break;
      default:
        break;
    }
    // if (setupResult.storageProvider != null) {
    await installDependencies(storageDependencies);
    // }

    await installDevDependencies([
      'build_runner',
      'change_app_package_name',
      'firebase_core_platform_interface',
      'flutter_launcher_icons',
      'flutter_lints',
      'freezed',
      'json_serializable',
      'lint',
      'riverpod_generator',
    ]);
  }

  Future<void> writePubspec() async {
    final pubspecFile = File("pubspec.yaml");
    final pubspecContent = pubspecFile.readAsStringSync();

    final yamlEditor = YamlEditor(pubspecContent);
    final assetsValue = json.decode(r'''
      {
        "uses-material-design": true,
        "assets": [
          "assets/images/",
          "assets/images/onboarding/",
          "assets/icons/"
        ]
      }
      ''');
    final flutterLaunchedValue = json.decode(r'''
      {
        "image_path": "assets/images/icon.png",
        "android": "ic_launcher",
        "ios": true,
        "remove_alpha_ios": true
      }
      ''');
    final flutterNativeSplashValue = json.decode(r'''
      {
        "color": "#FFFFFF",
        "fullscreen": true,
        "ios": true,
        "android": true,
        "image": "assets/images/splashscreen.png",
        "android_12": {
          "color": "#FFFFFF"
        }
      }
      ''');
    yamlEditor.update(['flutter'], assetsValue);
    yamlEditor.update(['flutter_launcher_icons'], flutterLaunchedValue);
    yamlEditor.update(['flutter_native_splash'], flutterNativeSplashValue);

    pubspecFile.writeAsStringSync(yamlEditor.toString());
  }
}
