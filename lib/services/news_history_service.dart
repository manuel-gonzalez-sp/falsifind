import 'package:falsifind/models/news_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'news_history_service.g.dart';

@Riverpod(keepAlive: true)
class NewsHistoryService extends _$NewsHistoryService {
  @override
  Future<List<NewsItem>> build() async => [];

  Future<void> consultNewsItem(NewsItem item) async {
    final previousState = await future;
    previousState.remove(item);

    final updated = item.copyWith(consultationDate: DateTime.now());

    state = AsyncData([updated, ...previousState]);
  }
}
