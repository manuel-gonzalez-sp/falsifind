import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_item.freezed.dart';
part 'news_item.g.dart';

@freezed
class NewsItem with _$NewsItem {
  const factory NewsItem({
    required String id,
    required String title,
    required DateTime date,
    required String content,
    required String sourceUrl,
    String? coverUrl,
    DateTime? consultationDate,
  }) = _NewsItem;

  factory NewsItem.fromJson(Map<String, dynamic> json) => _$NewsItemFromJson(json);
}
