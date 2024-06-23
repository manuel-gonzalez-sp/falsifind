import 'package:falsifind/config/app_theme.dart';
import 'package:falsifind/services/news_history_service.dart';
import 'package:falsifind/widgets/news_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icon.dart';
import 'package:lottie/lottie.dart';

class NewsHistoryScreen extends HookConsumerWidget {
  const NewsHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchField = useTextEditingController();

    //final historyItems = ref.watch(newsHistoryServiceProvider);
    final historyItems = ref.watch(newsHistoyFilteredProvider);

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 50.0,
          decoration: const BoxDecoration(color: AppColors.secondary, border: Border.symmetric(horizontal: BorderSide(color: AppColors.outline, width: 2.0))),
          child: TextField(
            controller: searchField,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
            cursorColor: Colors.white,
            onChanged: (value) {
              ref.read(newsHistoyFilteredProvider.notifier).filter(searchField.text);
            },
            decoration: InputDecoration(
              hintText: 'Buscar...',
              hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white60),
              suffixIcon: const LineIcon.search(),
              suffixIconColor: AppColors.onSecondary,
              focusColor: AppColors.onSecondary,
              border: InputBorder.none,
            ),
          ),
        ),
        Expanded(
          child: historyItems.when(
            data: (value) {
              if (value.isEmpty) {
                return Center(
                  child: Opacity(
                    opacity: 0.5,
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.6,
                      child: Column(children: [
                        const Spacer(),
                        Lottie.asset('assets/animations/empty-list.json', repeat: true, fit: BoxFit.fitWidth),
                        Text(
                          searchField.text == '' ? 'Parece que todavía no escaneas ninguna noticia...!' : 'Sin coincidencias',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge,
                          //style: Theme.of(context).textStyle.,
                        ),
                        const Spacer(flex: 2),
                      ]),
                    ),
                  ),
                );
              }
              //final filtered = value.where((item) => item.title.contains(searchField.text));
              return ListView.builder(
                itemCount: value.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = value[index];
                  return Dismissible(
                    key: Key(item.id),
                    background: Container(
                      color: AppColors.danger,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 32.0),
                      child: const LineIcon.trash(color: AppColors.onDanger),
                    ),
                    secondaryBackground: Container(
                      color: AppColors.danger,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 32.0),
                      child: const LineIcon.trash(color: AppColors.onDanger),
                    ),
                    onDismissed: (_) => ref.read(newsHistoryServiceProvider.notifier).removeItem(item.id),
                    child: NewsCard(item),
                  );
                },
              );
            },
            error: (error, _) => Text('Error $error'),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
        )
      ],
    );
  }
}
