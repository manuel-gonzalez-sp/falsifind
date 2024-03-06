import 'package:falsifind/models/news_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'news_feed_service.g.dart';

@Riverpod(keepAlive: true)
class NewsFeedService extends _$NewsFeedService {
  @override
  Future<List<NewsItem>> build() async => [
        NewsItem(id: const Uuid().v4(), title: "El naranjo c la come 1", date: DateTime.now(), content: "Efectivamente es contenido", sourceUrl: "aki.com"),
        NewsItem(id: const Uuid().v4(), title: "El naranjo c la come 2", date: DateTime.now(), content: "Efectivamente es contenido", sourceUrl: "aki.com"),
        NewsItem(id: const Uuid().v4(), title: "El naranjo c la come 3", date: DateTime.now(), content: "Efectivamente es contenido", sourceUrl: "aki.com"),
        NewsItem(id: const Uuid().v4(), title: "El naranjo c la come 4", date: DateTime.now(), content: "Efectivamente es contenido", sourceUrl: "aki.com"),
        NewsItem(id: const Uuid().v4(), title: "El naranjo c la come 5", date: DateTime.now(), content: "Efectivamente es contenido", sourceUrl: "aki.com"),
      ];

  Future<void> loadMore() async {
    final previousState = await future;

    final newItem = NewsItem(
      id: const Uuid().v4(),
      title: "Elon Musk is now working out of Twitter HQ ${previousState.length}",
      date: DateTime.now(),
      content:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      sourceUrl: "aki.com",
      coverUrl:
          "https://image.ondacero.es/clipping/cmsimages01/2022/06/28/CB2355F3-42C5-4531-99C3-815293F4B7D3/asi-joe-biden-sus-estudios-familia-sueldo-carrera-politica_103.jpg?crop=800,600,x100,y0&width=1200&height=900&optimize=low&format=webply",
    );

    state = AsyncData([...previousState, newItem]);
  }
}
