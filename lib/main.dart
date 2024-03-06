import 'package:falsifind/config/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'config/app_router.dart';

void main() {
  runApp(const ProviderScope(child: FalsiFind()));
}

class FalsiFind extends ConsumerWidget {
  const FalsiFind({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeModeProvider);

    return MaterialApp.router(
      theme: appThemeLight,
      darkTheme: appThemeDark,
      themeMode: themeMode,
      routerConfig: appRouter,
    );
  }
}
