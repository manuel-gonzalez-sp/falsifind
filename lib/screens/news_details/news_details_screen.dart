import 'package:falsifind/config/app_theme.dart';
import 'package:falsifind/services/news_feed_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icon.dart';

class NewsDetailsScreen extends HookConsumerWidget {
  const NewsDetailsScreen(this.newsId, {super.key, this.content});

  final String newsId;
  final String? content;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        title: Text(
          'Detalles de la noticia',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontFamily: 'SecularOne',
                color: Colors.black,
              ),
        ),
        leading: IconButton(onPressed: () => context.pop(), icon: const LineIcon.angleLeft()),
        shape: const Border(
          bottom: BorderSide(color: AppColors.lightOutline, width: 2),
        ),
        backgroundColor: AppColors.lightBackground,
      ),
      body: Align(
        alignment: Alignment.center,
        child: Text(content ?? newsId),
      ),
    );
  }
}
