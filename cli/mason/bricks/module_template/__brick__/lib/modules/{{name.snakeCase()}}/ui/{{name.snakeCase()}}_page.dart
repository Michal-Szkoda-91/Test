import 'package:apparence_kit/modules/{{name.snakeCase()}}/providers/{{name.snakeCase()}}_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The page of the {{name.pascalCase()}} module
/// Change it to your needs
/// If you intend to use this page in the bottom navigation bar, you can remove the Scaffold 
class {{name.pascalCase()}}Page extends ConsumerWidget {
  const {{name.pascalCase()}}Page({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Get the state of the provider
    final state = ref.watch({{name.camelCase()}}NotifierProvider);

    /// Build the page using the state
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Container(),
      ),
    );
  }
}