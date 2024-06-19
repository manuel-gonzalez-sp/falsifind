import 'package:falsifind/config/app_theme.dart';
import 'package:falsifind/models/news_item.dart';
import 'package:falsifind/services/news_classification_service.dart';
import 'package:falsifind/services/news_history_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailsScreen extends HookConsumerWidget {
  const NewsDetailsScreen(this.url, {super.key});

  final String? url;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = useState(true);
    final webview = useState(WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted));
    final item = useState<NewsItem?>(null);

    final saved = useState(false);
    final result = useState<double?>(null);

    useEffect(() {
      if (url != null) {
        webview.value.setNavigationDelegate(
          NavigationDelegate(onPageFinished: (url) {
            ref.read(newsHistoryServiceProvider.notifier).getItem(url, webview.value).then((value) {
              item.value = value;
              saved.value = true;

              final provider = ref.read(newsClassificationServiceProvider.notifier);
              provider.loadModel(context).then((value) {
                provider.makeClassification(item.value!).then((prediction) {
                  result.value = prediction;
                });
              });
            });
          }),
        );
        webview.value.loadRequest(Uri.parse(url!));

        loading.value = false;
      }
      return null;
    }, [loading, webview, saved]);

    return Column(
      children: [
        Expanded(
          child: loading.value ? const CircularProgressIndicator() : WebViewWidget(controller: webview.value),
        ),
        if (result.value != null)
          Container(
            color: Colors.orange,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            child: Text(result.value!.toString()),
          ),
        Container(
          color: AppColors.secondary,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          child: Text(!saved.value ? 'Guardando...' : 'Guardado'),
        ),
      ],
    );
  }
}


// import 'package:falsifind/config/app_theme.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:go_router/go_router.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:line_icons/line_icon.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class NewsDetailsScreen extends HookConsumerWidget {
//   const NewsDetailsScreen(this.url, {super.key});

//   final String? url;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final loading = useState(false);
//     final webview = useState(WebViewController());

//     useEffect(() {
//       if (content != null) {
//         webview.value.loadRequest(Uri.parse(content!));
//         loading.value = false;

//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               backgroundColor: const Color(0xFF93d8fa),
//               padding: const EdgeInsets.all(16),
//               content: Row(
//                 children: [
//                   const CircularProgressIndicator(color: Colors.black),
//                   const SizedBox(width: 20),
//                   Text(
//                     "Analizando noticia...",
//                     style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                           fontFamily: 'SecularOne',
//                           color: Colors.black,
//                         ),
//                   )
//                 ],
//               ),
//               duration: const Duration(seconds: 7), // Long duration to ensure it stays
//             ),
//           );

//           Future.delayed(const Duration(seconds: 7), () {
//             ScaffoldMessenger.of(context).hideCurrentSnackBar();

//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 backgroundColor: const Color(0xFFfcd7da),
//                 padding: const EdgeInsets.all(16),
//                 content: Column(crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisSize: MainAxisSize.min, children: [
//                   Row(
//                     children: [
//                       const LineIcon.thumbsDown(color: Color(0xFF9e0313), size: 30),
//                       const SizedBox(width: 20),
//                       Text(
//                         "97% Fake News",
//                         style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                               fontFamily: 'SecularOne',
//                               color: const Color(0xFF9e0313),
//                             ),
//                       )
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   TextButton.icon(
//                       style: OutlinedButton.styleFrom(
//                         side: BorderSide(width: 2, color: const Color(0xFF9e0313)),
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0) // Square edges
//                             ),
//                       ),
//                       onPressed: () {},
//                       icon: LineIcon.brain(
//                         color: const Color(0xFF9e0313),
//                       ),
//                       label: Text(
//                         'Análisis detallado',
//                         style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                               fontFamily: 'DidactGothic',
//                               color: const Color(0xFF9e0313),
//                             ),
//                       ))
//                 ]),
//                 duration: const Duration(days: 33), // Long duration to ensure it stays
//               ),
//             );
//           });
//         });
//       }

//       loading.value = false;
//       return null;
//       //() => ScaffoldMessenger.of(context).hideCurrentSnackBar();
//     }, [webview, loading]);

//     return Scaffold(
//         backgroundColor: AppColors.lightBackground,
//         appBar: AppBar(
//           title: Text(
//             'Detalles de la noticia',
//             style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                   fontFamily: 'SecularOne',
//                   color: Colors.black,
//                 ),
//           ),
//           leading: IconButton(
//               onPressed: () {
//                 ScaffoldMessenger.of(context).clearSnackBars();
//                 context.pop();
//               },
//               icon: const LineIcon.angleLeft()),
//           shape: const Border(
//             bottom: BorderSide(color: AppColors.lightOutline, width: 2),
//           ),
//           backgroundColor: AppColors.lightBackground,
//         ),
//         body: loading.value ? const Center(child: CircularProgressIndicator()) : WebViewWidget(controller: webview.value)

//         // Align(
//         //     alignment: Alignment.center,
//         //     child: Text(content ?? newsId),
//         //   ),
//         );
//   }
// }
