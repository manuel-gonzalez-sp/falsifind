import 'package:falsifind/config/app_theme.dart';
import 'package:falsifind/services/shared_intent_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'config/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(const ProviderScope(child: FalsiFind())),
  );
}

class FalsiFind extends HookConsumerWidget {
  const FalsiFind({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeModeProvider);

    ref.listen(sharedIntentServiceProvider, (previous, next) {
      next.whenData((value) {
        ref.read(sharedIntentServiceProvider.notifier).gotoDetails(value);
      });
    });

    return MaterialApp.router(
      theme: appThemeLight,
      darkTheme: appThemeDark,
      themeMode: themeMode,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
