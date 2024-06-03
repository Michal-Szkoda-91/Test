import 'dart:async';
import 'dart:io';

import 'package:apparence_cli/src/commands/command_extension.dart';
import 'package:apparence_cli/src/commands/models/setup_config.dart';
import 'package:apparence_cli/src/commands/setup_command.dart';
import 'package:apparence_cli/src/process_runner.dart';
import 'package:apparence_cli/src/templates/camera_bundle.dart';
import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:mason/mason.dart';

class CameraBuilderCommand extends Command<int> {
  final GeneratorBuilder _generator;
  final Logger _logger;
  final String? outputPath;

  CameraBuilderCommand({
    Logger? logger,
    GeneratorBuilder? generator,
    this.outputPath,
  })  : _logger = logger ?? Logger(),
        _generator = generator ?? MasonGenerator.fromBundle {
    argParser.addOption(
      'exifLocation',
      help: 'add exif location to your photos',
      mandatory: true,
      aliases: ['exif'],
    );
    argParser.addOption(
      'uiType',
      help: 'The camera ui type (basic, custom).',
      mandatory: false,
      aliases: ['uiType'],
    );
  }

  @override
  String get description => '''Add a camera UI from template''';

  @override
  String get usage =>
      "$description\nusage example: dart pub global run apparence_cli camera --exifLocation=true --uiType=basic .";

  @override
  String get name => "camera";

  @override
  FutureOr<int> run() async {
    final outputPath = _getOutputPath();
    var setupResult = SetupResult.load(outputPath);
    _logger.info('📸 Adding camera template to your app...');
    final cameraConfig = parseCameraConfigArgs;

    await installDependencies(setupResult);
    final cameraGenerator = await _generator(cameraBundle);
    await cameraGenerator.generate(
      DirectoryGeneratorTarget(_relativeDirectory("lib/modules")),
      vars: {
        'basic': cameraConfig.uiType == CameraUiType.basic,
        'exifLocation': cameraConfig.withExifLocation,
      },
    );

    _logger.info('...writing apparenceKit setup result');
    setupResult = setupResult.copyWith(
      cameraConfig: cameraConfig,
    );
    setupResult.write(_getOutputPath());
    _logger.success('✅ ApparenceKit camera template added');
    _logger.success('''
      =====================================================  
      👉 Please edit native permissions on iOS and Android
      =====================================================  
    ''');
    _logger.success(
        '''🤖 Android: Don't forget to add the following permissions to your AndroidManifest.xml
        (you can find it in android/app/src/main/AndroidManifest.xml)
        <uses-permission android:name="android.permission.CAMERA" />
      ''');
    if (cameraConfig.withExifLocation) {
      _logger.success(
          '''<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />''');
    }

    _logger.success('''
        🍏 iOS: Don't forget to add the following permissions to your Info.plist
        (open xcode and ios/Runner/Info.plist. Never edit this file from VSCode)
        <key>NSCameraUsageDescription</key>
        <string>Need camera access to take photos</string>
        <key>NSMicrophoneUsageDescription</key>
        <string>Need microphone access to record videos</string>
    ''');
    if (cameraConfig.withExifLocation) {
      _logger.success('''<key>NSLocationWhenInUseUsageDescription</key>
        <string>Need location access to add exif location to your photos</string>
        <key>NSLocationAlwaysUsageDescription</key>
        <string>Need location access to add exif location to your photos</string>
      ''');
    }
    _logger.success('''
      ==============================  
      📸 A camera Page has been generated in (lib/modules/camera)
      - add this page to your router (lib/router.dart)
      This template is using the camerawesome plugin. 
      You can get the full documentation here: https://docs.page/Apparence-io/camera_awesome
    ''');

    return ExitCode.success.code;
  }

  CameraConfig get parseCameraConfigArgs => CameraConfig(
        uiType: cameraUiTypefromString(argResults?['uiType'] as String?),
        withExifLocation: bool.parse(argResults?['exifLocation'] ?? 'false'),
      );

  Future<void> installDependencies(SetupResult config) async {
    List<ProcessRunner> processes = [];
    processes.add(AddDependencyCmdRunner('camerawesome'));
    processes.add(AddDependencyCmdRunner('path_provider'));
    processes.add(AddDependencyCmdRunner('better_open_file'));
    processes.add(AddDependencyCmdRunner('cross_file'));
    processes.add(RefreshDependencyCmdRunner());
    for (var element in processes) {
      await element.run();
    }
  }

  ArgResults get _argResults => argResults!;

  Directory _relativeDirectory(String path) {
    final directory = Directory("${_getOutputPath()}/$path");
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }
    return directory;
  }

  String _getOutputPath() {
    if (outputPath != null) {
      return outputPath!;
    }
    return getOutputPath(_argResults);
  }
}
