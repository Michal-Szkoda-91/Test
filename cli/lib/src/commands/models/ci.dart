enum CIProviders { codemagic, github, gitlab }

CIProviders? ciProviderFrom(String? value) {
  if (value == null) {
    return null;
  }
  switch (value) {
    case 'codemagic':
      return CIProviders.codemagic;
    case 'github':
      return CIProviders.github;
    case 'gitlab':
      return CIProviders.gitlab;
    default:
      throw Exception('Unknown storage provider: $value');
  }
}
