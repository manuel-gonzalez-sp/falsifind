import 'package:falsifind/models/news_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'news_saved_service.g.dart';

@Riverpod(keepAlive: true)
class NewsSavedService extends _$NewsSavedService {
  @override
  Future<Set<NewsItem>> build() async => {};

  Future<void> saveNewsItem(NewsItem item) async {
    final previousState = await future;
    final contains = previousState.contains(item);

    if (!contains) {
      state = AsyncData({...previousState, item});
    }
  }
}
