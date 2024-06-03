enum RemoteConfigProvider {
  firebase,
}

RemoteConfigProvider? remoteConfigProviderFrom(String? value) {
  if (value == null) {
    return null;
  }
  switch (value) {
    case 'firebase':
      return RemoteConfigProvider.firebase;
    default:
      throw Exception('Unknown remote config provider: $value');
  }
}
