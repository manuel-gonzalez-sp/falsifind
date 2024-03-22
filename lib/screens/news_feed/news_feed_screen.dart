import 'dart:math';

import 'package:falsifind/config/app_theme.dart';
import 'package:falsifind/services/news_feed_service.dart';
import 'package:falsifind/widgets/news_card_compact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icon.dart';

class NewsFeedScreen extends HookConsumerWidget {
  const NewsFeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();

    final items = ref.watch(newsFeedServiceProvider);

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  'Buscar...',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.darkOutline,
                        fontWeight: FontWeight.bold,
                      ),
                )),
                IconButton(
                    onPressed: () {},
                    icon: LineIcon.search(
                      color: AppColors.darkOutline,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: LineIcon.bookmark(
                      color: AppColors.darkOutline,
                    )),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.black,
            ),
          ),
          Expanded(
            child: items.when(
              // data: (value) => CardSwiper(
              //     numberOfCardsDisplayed: 3,
              //     cardBuilder: (context, index, horizontalOffsetPercentage, verticalOffsetPercentage) {
              //       final item = value[index];
              //       return NewsCardCompact(item);
              //     },
              //     cardsCount: value.length),

              data: (value) => ListView.builder(
                padding: const EdgeInsets.only(bottom: 40.0),
                controller: scrollController,
                itemCount: value.length,
                itemBuilder: (context, index) {
                  final item = value[index];
                  final fake = Random().nextBool();
                  return NewsCardCompact(item, isFake: fake);
                },
              ),
              error: (error, _) => Text('Error: $error'),
              loading: () => const CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
