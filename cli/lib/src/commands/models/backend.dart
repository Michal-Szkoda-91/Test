enum BackendProvider {
  firebase,
  supabase,
  restApi;

  static BackendProvider? fromString(String? name) {
    if (name == null) return null;
    for (final provider in BackendProvider.values) {
      if (provider.name == name) {
        return provider;
      }
    }
    return null;
  }
}
