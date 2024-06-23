import 'package:falsifind/config/app_router.dart';
import 'package:falsifind/config/app_theme.dart';
import 'package:falsifind/models/news_item.dart';
import 'package:falsifind/services/news_classification_service.dart';
import 'package:falsifind/services/news_history_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icon.dart';
import 'package:lottie/lottie.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum NewsDetailsState { iddle, classifying, classified, error }

class NewsDetailsScreen extends HookConsumerWidget {
  const NewsDetailsScreen(this.url, {super.key});

  final Uri url;

  get loading => false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsItem = useState<NewsItem?>(null);
    final newsDetails = useState(NewsDetailsState.iddle);

    final webview = useState(WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted));
    final progress = useRef(0.0);

    Future<void> classify() async {
      if (newsItem.value != null) {
        if (newsItem.value!.content != "No content found") {
          final result = await ref.read(newsClassificationServiceProvider.notifier).classify(newsItem.value!);
          if (result != null) {
            newsItem.value = newsItem.value!.copyWith(truthness: result);
            await ref.read(newsHistoryServiceProvider.notifier).updateItem(newsItem.value!);
          }
        }
      }
    }

    useEffect(() {
      webview.value.setNavigationDelegate(NavigationDelegate(
        onNavigationRequest: (request) => NavigationDecision.prevent,
        onProgress: (value) => progress.value = value / 100.0,
        onPageFinished: (_) {
          progress.value = 1.0;
          ref.read(newsHistoryServiceProvider.notifier).getItem(url, webview.value).then((value) {
            if (value != null) {
              newsItem.value = value;
              newsDetails.value = value.truthness != null ? NewsDetailsState.classified : NewsDetailsState.classifying;
            } else {
              newsDetails.value = NewsDetailsState.error;
            }
          });
        },
      ));
      webview.value.loadRequest(url);
      return null;
    }, []);

    final animationController = useAnimationController(duration: const Duration(milliseconds: 700));
    final animation = CurvedAnimation(parent: animationController, curve: Curves.easeInOutExpo);
    useEffect(() {
      if (newsDetails.value != NewsDetailsState.iddle) {
        animationController.forward().then((_) {
          if (newsDetails.value == NewsDetailsState.classifying) {
            classify().then((_) {
              animationController.reverse().then((_) {
                newsDetails.value = newsItem.value!.truthness != null ? NewsDetailsState.classified : NewsDetailsState.error;
              });
            });
          }
        });
      } else {
        animationController.reverse();
      }
      return null;
    }, [newsDetails.value]);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(alignment: Alignment.center, children: [
            Container(
              decoration: const BoxDecoration(border: Border.symmetric(horizontal: BorderSide(color: AppColors.outline, width: 2))),
              child: LinearProgressIndicator(
                value: progress.value,
                minHeight: 50,
                backgroundColor: AppColors.outline,
                color: AppColors.secondary,
              ),
            ),
            Row(children: [
              Expanded(
                child: IconButton(
                  icon: const LineIcon.angleLeft(color: AppColors.onSecondary),
                  onPressed: () => appRouter.pop(),
                ),
              ),
              Expanded(
                flex: 5,
                child: Text(url.host, textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.onSecondary)),
              ),
              const Spacer(),
            ]),
          ]),
          Expanded(
            child: progress.value < 1.0
                ? Center(
                    child: SizedBox(
                        width: MediaQuery.sizeOf(context).width / 2,
                        child: Opacity(
                          opacity: 0.5,
                          child: Lottie.asset('assets/animations/loading-newspaper.json', repeat: true, fit: BoxFit.contain),
                        )),
                  )
                : WebViewWidget(controller: webview.value),
          ),
          SizeTransition(
            sizeFactor: animation,
            axisAlignment: -1.0,
            child: switch (newsDetails.value) {
              NewsDetailsState.iddle => const SizedBox(),
              NewsDetailsState.classifying => Container(
                  color: AppColors.accent,
                  padding: const EdgeInsets.all(32.0),
                  child: Row(children: [
                    const Expanded(child: Center(child: CircularProgressIndicator(color: AppColors.onAccent))),
                    Expanded(
                      flex: 5,
                      child: Text(
                        'Analizando...',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.onAccent),
                      ),
                    ),
                    const Spacer(),
                  ]),
                ),
              NewsDetailsState.classified => Container(
                  color: newsItem.value!.truthness! > 0.7 ? AppColors.success : AppColors.danger,
                  padding: const EdgeInsets.all(24.0),
                  child: Row(children: [
                    Expanded(
                        child: newsItem.value!.isTrue!
                            ? const LineIcon.thumbsUp(color: AppColors.onSuccess, size: 40)
                            : const LineIcon.thumbsDown(color: AppColors.onDanger, size: 40)),
                    Expanded(
                      flex: 5,
                      child: newsItem.value!.isTrue!
                          ? Text(
                              '${(newsItem.value!.truthness! * 100.0).toInt()}% Verdadero',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.onSuccess),
                            )
                          : Text(
                              '${(100.0 - newsItem.value!.truthness! * 100.0).toInt()}% Falso',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.onDanger),
                            ),
                    ),
                    const Spacer(),
                  ]),
                ),
              NewsDetailsState.error => Container(
                  color: AppColors.danger,
                  padding: const EdgeInsets.all(24.0),
                  child: Row(children: [
                    const Expanded(child: LineIcon.exclamationCircle(color: AppColors.onDanger, size: 40)),
                    Expanded(
                      flex: 5,
                      child: Text(
                        'No se pudo analizar esta noticia.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.onDanger),
                      ),
                    ),
                    const Spacer(),
                  ]),
                ),
            },
          ),
        ],
      ),
    );
  }
}
