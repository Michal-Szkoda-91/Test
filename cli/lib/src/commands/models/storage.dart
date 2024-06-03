enum StorageProviders {
  firebase,
  supabase,
  generic,
}

StorageProviders? storageProviderFrom(String? value) {
  if (value == null) {
    return null;
  }
  for (final provider in StorageProviders.values) {
    if (provider.name == value) {
      return provider;
    }
  }
  throw Exception('Unknown storage provider: $value');
}
