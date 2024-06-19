import 'package:falsifind/config/app_theme.dart';
import 'package:falsifind/services/news_history_service.dart';
import 'package:falsifind/widgets/news_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icon.dart';

class NewsHistoryScreen extends HookConsumerWidget {
  const NewsHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchField = useTextEditingController();
    final historyItems = ref.watch(newsHistoryServiceProvider);

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
          decoration: const BoxDecoration(color: Colors.black, border: Border.symmetric(horizontal: BorderSide(color: AppColors.secondary, width: 2.0))),
          child: TextField(
            controller: searchField,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white, height: 2),
            cursorColor: AppColors.secondary,
            decoration: InputDecoration(
              hintText: 'Buscar...',
              hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white70),
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
              //final filtered = value.where((item) => item.title.contains(searchField.text));
              return ListView.builder(
                itemCount: value.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = value[index];
                  return Dismissible(
                    key: Key(item.id),
                    background: Container(
                      color: AppColors.danger,
                      child: const LineIcon.trash(
                        color: AppColors.onDanger,
                      ),
                    ),
                    onDismissed: (_) => ref.read(newsHistoryServiceProvider.notifier).removeItem(item.id),
                    child: NewsCard(item),
                  );
                },
              );
            },
            error: (error, _) => Text('Error $error'),
            loading: () => const CircularProgressIndicator(),
          ),
        )
      ],
    );
  }
}
