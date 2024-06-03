// ignore_for_file: avoid_redundant_argument_values

import 'package:apparence_kit/modules/camera/xfile_extension.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:camerawesome/pigeon.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_io/io.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CameraAwesomeBuilder.awesome(
        saveConfig: SaveConfig.photoAndVideo(
          initialCaptureMode: CaptureMode.photo,
          mirrorFrontCamera: true,
          photoPathBuilder: _photoPathBuilder,
          videoOptions: VideoOptions(
            enableAudio: true,
            ios: CupertinoVideoOptions(
              fps: 10,
            ),
            android: AndroidVideoOptions(
              bitrate: 6000000,
              fallbackStrategy: QualityFallbackStrategy.lower,
            ),
          ),
          exifPreferences: ExifPreferences(saveGPSLocation: {{exifLocation}}),
        ),
        sensorConfig: SensorConfig.single(
          sensor: Sensor.position(SensorPosition.back),
          flashMode: FlashMode.auto,
          aspectRatio: CameraAspectRatios.ratio_16_9,
          zoom: 0.0,
        ),
        enablePhysicalButton: true,
        previewFit: CameraPreviewFit.cover,
        onMediaTap: (mediaCapture) {
          mediaCapture.captureRequest.when(
            single: (single) {
              debugPrint('single: ${single.file?.path}');
              single.file?.open();
            },
          );
        },
        availableFilters: awesomePresetFiltersList,
      ),
    );
  }

  Future<CaptureRequest> _photoPathBuilder(List<Sensor> sensors) async {
    Directory extDir;
    if (Platform.isAndroid) {
      extDir = Directory("/storage/emulated/0/Download");
    } else {
      extDir = (await getExternalStorageDirectory())!;
    }
    final testDir =
        await Directory('${extDir.path}/camerawesome').create(recursive: true);
    final String filePath =
        '${testDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
    return SingleCaptureRequest(filePath, sensors.first);
  }
}
