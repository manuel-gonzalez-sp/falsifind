import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NewsDetailsScreen extends HookConsumerWidget {
  const NewsDetailsScreen(this.newsId, {super.key});

  final String newsId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News details'),
      ),
      body: Text(newsId),
    );
  }
}
