import 'package:falsifind/config/app_theme.dart';
import 'package:falsifind/services/news_feed_service.dart';
import 'package:falsifind/widgets/news_card_compact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NewsFeedScreen extends HookConsumerWidget {
  const NewsFeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();

    final items = ref.watch(newsFeedServiceProvider);

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: items.when(
        // data: (value) => CardSwiper(
        //     numberOfCardsDisplayed: 3,
        //     cardBuilder: (context, index, horizontalOffsetPercentage, verticalOffsetPercentage) {
        //       final item = value[index];
        //       return NewsCardCompact(item);
        //     },
        //     cardsCount: value.length),

        data: (value) => ListView.builder(
          controller: scrollController,
          itemCount: value.length,
          itemBuilder: (context, index) {
            final item = value[index];
            return NewsCardCompact(item);
          },
        ),
        error: (error, _) => Text('Error: $error'),
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}
