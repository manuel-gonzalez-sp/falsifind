import 'dart:math';

import 'package:faker_dart/faker_dart.dart';
import 'package:falsifind/models/news_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'news_feed_service.g.dart';

@Riverpod(keepAlive: true)
class NewsFeedService extends _$NewsFeedService {
  @override
  Future<List<NewsItem>> build() async {
    final data = <NewsItem>[];
    final faker = Faker.instance;
    for (var i = 0; i < 15; i++) {
      final hours = Random().nextInt(72);
      final news = NewsItem(
        id: faker.datatype.uuid(),
        title: faker.lorem.sentence(),
        consultationDate: DateTime.now().subtract(Duration(hours: hours)),
        date: DateTime.now(),
        content: faker.lorem.paragraph(sentenceCount: 30),
        sourceUrl: faker.internet.url(),
        coverUrl: faker.image.loremPicsum.grayImage(width: 100, height: 100, seed: faker.datatype.uuid()),
      );
      data.add(news);
    }
    return data;
  }

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
