import 'package:falsifind/config/app_router.dart';
import 'package:falsifind/config/app_theme.dart';
import 'package:falsifind/services/news_classification_service.dart';
import 'package:falsifind/services/shared_intent_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:localstorage/localstorage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(const ProviderScope(child: FalsiFind())),
  );
}

// class FalsiFind extends StatefulHookConsumerWidget {
//   const FalsiFind({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _FalsiFindState();
// }

// class _FalsiFindState extends ConsumerState<FalsiFind> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
// ref.listen(sharedIntentServiceProvider, (previous, next) {
//   next.whenData((value) async {
//     print(value);
//     final sharedData = await ref.read(sharedIntentServiceProvider.notifier).getData(value);
//     final url = Uri.tryParse(sharedData ?? '');
//     // if (url != null) {
//     //   appRouter.push('/news_details', extra: url);
//     // }
//   });
// });

//     return MaterialApp.router(
//       theme: appThemeLight,
//       routerConfig: appRouter,
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

class FalsiFind extends HookConsumerWidget {
  const FalsiFind({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      ref.read(newsClassificationServiceProvider.notifier).init();
      ref.listenManual(sharedIntentServiceProvider, (previous, next) {
        next.whenData((value) async {
          final sharedData = await ref.read(sharedIntentServiceProvider.notifier).getData(value);
          final url = Uri.tryParse(sharedData ?? '::not-valid::');
          if (url != null) {
            appRouter.push('/news_details', extra: url);
          }
        });
      });
      return null;
    }, []);

    return MaterialApp.router(
      theme: appThemeLight,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
