import 'package:apparence_cli/src/commands/generators/base_module_generator.dart';
import 'package:apparence_cli/src/commands/models/backend.dart';
import 'package:apparence_cli/src/templates/module_authentication_bundle.dart';
import 'package:mason/mason.dart';

class AuthModuleGenerator extends BaseModuleGenerator {
  AuthModuleGenerator({
    required super.generator,
    required super.outputPath,
    required super.setupResult,
  });

  @override
  Future<void> run() async {
    final authModuleGenerator = await generator(moduleAuthenticationBundle);

    await authModuleGenerator.generate(
      DirectoryGeneratorTarget(relativeDirectory("")),
      vars: {
        'supabase': setupResult.backendProvider == BackendProvider.supabase,
        'firebase': setupResult.backendProvider == BackendProvider.firebase,
        'http_client': setupResult.backendProvider == BackendProvider.restApi,
        'googleSignIn': setupResult.useGoogleSignIn,
        'googlePlaySignIn': setupResult.useGooglePlaySignIn,
        'facebookSignIn': setupResult.useFacebookSignIn,
        'appleSignIn': setupResult.useAppleSignIn,
        'googleSignInClientId': null,
        'addGoogleSigninDependency':
            setupResult.useGoogleSignIn || setupResult.useGooglePlaySignIn,
        'anonymous_auth': setupResult.anonymousSignup,
      },
    );

    await renameProviderApi(
      'lib/modules/authentication/api',
      'authentication_api.dart',
    );
    // final apiPath = 'lib/modules/authentication/api';
    // for (final backendProvider in BackendProvider.values) {
    //   final path = '$apiPath/${backendProvider.name}_authentication_api.dart';
    //   final file = File(path);
    //   if (backendProvider == setupResult.backendProvider) {
    //     file.renameSync('$apiPath/_authentication_api.dart');
    //   } else {
    //     if (file.existsSync()) {
    //       file.deleteSync();
    //     }
    //   }
    // }
  }
}
