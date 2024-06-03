import 'package:apparence_cli/src/commands/generators/base_module_generator.dart';
import 'package:apparence_cli/src/commands/models/backend.dart';
import 'package:apparence_cli/src/templates/module_subscription_bundle.dart';
import 'package:mason/mason.dart';

class SubscriptionsModuleGenerator extends BaseModuleGenerator {
  SubscriptionsModuleGenerator({
    required super.generator,
    required super.outputPath,
    required super.setupResult,
  });

  @override
  Future<void> run() async {
    await installDependencies(['purchases_flutter']);

    final subscriptionsGenerator = await generator(moduleSubscriptionBundle);

    await subscriptionsGenerator.generate(
      DirectoryGeneratorTarget(relativeDirectory("")),
      vars: {
        'supabase': setupResult.backendProvider == BackendProvider.supabase,
        'firebase': setupResult.backendProvider == BackendProvider.firebase,
        'http_client': setupResult.backendProvider == BackendProvider.restApi,
        'translations': setupResult.internationalization,
        'sentry': setupResult.useSentry,
      },
    );

    await renameProviderApi(
      'lib/modules/subscription/api',
      'subscription_api.dart',
    );
  }
}
