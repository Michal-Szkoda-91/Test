import 'dart:convert';
import 'dart:io';

import 'package:apparence_cli/src/commands/auth_command.dart';
import 'package:apparence_cli/src/commands/models/backend.dart';
import 'package:apparence_cli/src/commands/models/remote_config.dart';
import 'package:apparence_cli/src/commands/models/storage.dart';

class SetupResult {
  final BackendProvider backendProvider;
  final String appName;
  final String bundleId;
  final bool anonymousSignup;
  final bool useFirebaseAuth;
  final bool useFirebaseFirestore;
  final bool useGoogleSignIn;
  final bool useGooglePlaySignIn;
  final bool useFacebookSignIn;
  final bool useAppleSignIn;
  final bool webCompat;
  final bool internationalization;
  final StorageProviders? storageProvider;
  final RemoteConfigProvider? remoteConfigProvider;
  final bool useSentry;
  final bool withOnboarding;
  final CameraConfig? cameraConfig;
  final AnalyticsProviders? analyticsProvider;

  SetupResult({
    required this.backendProvider,
    required this.useFirebaseAuth,
    required this.useFirebaseFirestore,
    required this.appName,
    required this.bundleId,
    this.anonymousSignup = false,
    this.useGoogleSignIn = false,
    this.useGooglePlaySignIn = false,
    this.useFacebookSignIn = false,
    this.useAppleSignIn = false,
    this.storageProvider,
    this.webCompat = false,
    this.internationalization = false,
    this.useSentry = false,
    this.withOnboarding = false,
    this.cameraConfig,
    this.remoteConfigProvider,
    this.analyticsProvider,
  });

  factory SetupResult.create() {
    return SetupResult(
        backendProvider: BackendProvider.restApi,
        appName: 'apparencekit-pro',
        bundleId: 'io.apparence',
        useFirebaseAuth: false,
        useFirebaseFirestore: false,
        useGoogleSignIn: false,
        useGooglePlaySignIn: false,
        useFacebookSignIn: false,
        useAppleSignIn: false,
        storageProvider: null,
        webCompat: false,
        internationalization: false,
        useSentry: false,
        withOnboarding: false,
        cameraConfig: null,
        remoteConfigProvider: null,
        analyticsProvider: null,
        anonymousSignup: false);
  }

  factory SetupResult.load(String path) {
    final file = File("$path/kit_setup.json");
    if (!file.existsSync()) {
      return SetupResult.create();
    }
    final Map<String, dynamic> json = jsonDecode(file.readAsStringSync());
    final backendProvider = BackendProvider.fromString(json['backendProvider']);
    return SetupResult(
      backendProvider: backendProvider!,
      appName: json['appName'],
      bundleId: json['bundleId'],
      anonymousSignup:
          json.containsKey('anonymousSignup') ? json['anonymousSignup'] : false,
      useFirebaseAuth: json['useFirebaseAuth'],
      useFirebaseFirestore: json['useFirebaseFirestore'],
      useGoogleSignIn: json['useGoogleSignIn'],
      useGooglePlaySignIn: json['useGooglePlaySignIn'],
      useFacebookSignIn: json['useFacebookSignIn'],
      useAppleSignIn: json['useAppleSignIn'],
      webCompat: json.containsKey('webCompat') ? json['webCompat'] : false,
      internationalization: json.containsKey('internationalization')
          ? json['internationalization']
          : false,
      storageProvider: storageProviderFrom(json['storageProvider']),
      useSentry: json.containsKey('useSentry') ? json['useSentry'] : false,
      withOnboarding:
          json.containsKey('withOnboarding') ? json['withOnboarding'] : false,
      cameraConfig: json.containsKey('cameraConfig') &&
              json['cameraConfig'] != null
          ? CameraConfig(
              uiType: cameraUiTypefromString(json['cameraConfig']['uiType']),
              withExifLocation: json['cameraConfig']['withExifLocation'],
            )
          : null,
      remoteConfigProvider: json.containsKey('remoteConfigProvider')
          ? remoteConfigProviderFrom(json['remoteConfigProvider'])
          : null,
      analyticsProvider: json.containsKey('analyticsProvider')
          ? analyticsProviderFrom(json['analyticsProvider'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'appName': appName,
      'bundleId': bundleId,
      'backendProvider': backendProvider.name,
      'useFirebaseAuth': useFirebaseAuth,
      'useFirebaseFirestore': useFirebaseFirestore,
      'useGoogleSignIn': useGoogleSignIn,
      'useGooglePlaySignIn': useGooglePlaySignIn,
      'useFacebookSignIn': useFacebookSignIn,
      'useAppleSignIn': useAppleSignIn,
      'storageProvider': storageProvider?.name,
      'webCompat': webCompat,
      'internationalization': internationalization,
      'useSentry': useSentry,
      'withOnboarding': withOnboarding,
      'cameraConfig': cameraConfig?.toJson(),
      'remoteConfigProvider': remoteConfigProvider?.name,
      'analyticsProvider': analyticsProvider?.name,
      'anonymousSignup': anonymousSignup,
    };
  }

  void write(String path) {
    final file = File("$path/kit_setup.json");
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }
    final json = toJson();
    file.writeAsStringSync(jsonEncode(json));
  }

  SetupResult copyWith({
    BackendProvider? backendProvider,
    String? appName,
    String? bundleId,
    bool? anonymousSignup,
    bool? useFirebaseAuth,
    bool? useFirebaseFirestore,
    bool? useGoogleSignIn,
    bool? useGooglePlaySignIn,
    bool? useFacebookSignIn,
    bool? useAppleSignIn,
    bool? webCompat,
    bool? internationalization,
    StorageProviders? storageProvider,
    bool? useSentry,
    bool? withOnboarding,
    CameraConfig? cameraConfig,
    RemoteConfigProvider? remoteConfigProvider,
    AnalyticsProviders? analyticsProvider,
  }) {
    return SetupResult(
      backendProvider: backendProvider ?? this.backendProvider,
      appName: appName ?? this.appName,
      bundleId: bundleId ?? this.bundleId,
      anonymousSignup: anonymousSignup ?? this.anonymousSignup,
      useFirebaseAuth: useFirebaseAuth ?? this.useFirebaseAuth,
      useFirebaseFirestore: useFirebaseFirestore ?? this.useFirebaseFirestore,
      useGoogleSignIn: useGoogleSignIn ?? this.useGoogleSignIn,
      useGooglePlaySignIn: useGooglePlaySignIn ?? this.useGooglePlaySignIn,
      useFacebookSignIn: useFacebookSignIn ?? this.useFacebookSignIn,
      useAppleSignIn: useAppleSignIn ?? this.useAppleSignIn,
      storageProvider: storageProvider ?? this.storageProvider,
      webCompat: webCompat ?? this.webCompat,
      internationalization: internationalization ?? this.internationalization,
      useSentry: useSentry ?? this.useSentry,
      withOnboarding: withOnboarding ?? this.withOnboarding,
      cameraConfig: cameraConfig ?? this.cameraConfig,
      remoteConfigProvider: remoteConfigProvider ?? this.remoteConfigProvider,
      analyticsProvider: analyticsProvider ?? this.analyticsProvider,
    );
  }

  SetupResult withProvider(AuthProvider provider) {
    switch (provider) {
      case AuthProvider.google:
        return copyWith(
          useGoogleSignIn: true,
        );
      case AuthProvider.googlePlay:
        return copyWith(
          useGooglePlaySignIn: true,
        );
      case AuthProvider.facebook:
        return copyWith(
          useFacebookSignIn: true,
        );
      case AuthProvider.apple:
        return copyWith(
          useAppleSignIn: true,
        );
      default:
        return this;
    }
  }
}

enum CameraUiType {
  basic,
}

CameraUiType cameraUiTypefromString(String? name) {
  switch (name) {
    case 'basic':
      return CameraUiType.basic;
    default:
      return CameraUiType.basic;
  }
}

class CameraConfig {
  final CameraUiType uiType;
  final bool withExifLocation;

  CameraConfig({
    required this.uiType,
    required this.withExifLocation,
  });

  toJson() {
    return {
      'uiType': uiType.toString(),
      'withExifLocation': withExifLocation,
    };
  }
}

enum AnalyticsProviders {
  firebase,
  mixpanel,
}

AnalyticsProviders? analyticsProviderFrom(String? name) {
  if (name == null) return null;
  switch (name) {
    case 'firebase':
      return AnalyticsProviders.firebase;
    case 'mixpanel':
      return AnalyticsProviders.mixpanel;
    default:
      throw ArgumentError.value(
        name,
        'name',
        'name must be firebase or mixpanel',
      );
  }
}
