import 'package:falsifind/utils/text.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:timeago/timeago.dart' as timeago;

part 'news_item.freezed.dart';
part 'news_item.g.dart';

@freezed
class NewsItem with _$NewsItem {
  const NewsItem._();

  const factory NewsItem({
    required String id,
    required String title,
    required String content,
    required String url,
    required DateTime consultationDate,
    String? coverUrl,
    DateTime? date,
    double? truthness,
  }) = _NewsItem;

  factory NewsItem.fromJson(Map<String, dynamic> json) => _$NewsItemFromJson(json);

  //bool isFake() => truthness > 0.5;

  String? siteName() {
    final uri = Uri.tryParse(url);
    if (uri != null) {
      return uri.host;
    }
    return null;
  }

  String dateString() {
    return timeago.format(date ?? consultationDate, locale: 'es').toCapitalized();
  }
}
