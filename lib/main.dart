import 'package:falsifind/config/app_theme.dart';
import 'package:falsifind/services/shared_intent_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:localstorage/localstorage.dart';

import 'config/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(const ProviderScope(child: FalsiFind())),
  );
}

class FalsiFind extends HookConsumerWidget {
  const FalsiFind({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(sharedIntentServiceProvider, (previous, next) {
      next.whenData((value) async {
        final sharedData = await ref.read(sharedIntentServiceProvider.notifier).getData(value);
        if (sharedData != null) {
          appRouter.push('/news_details', extra: sharedData);
        }
      });
    });

    return MaterialApp.router(
      theme: appThemeLight,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
