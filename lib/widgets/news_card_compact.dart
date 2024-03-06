import 'package:falsifind/models/news_item.dart';
import 'package:falsifind/widgets/highlight_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icon.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsCardCompact extends StatelessWidget {
  const NewsCardCompact(this.item, {super.key, this.isFake = false});

  final NewsItem item;
  final bool isFake;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        //height: 200,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          border: const Border(bottom: BorderSide(color: Colors.black12)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: item.coverUrl != null ? decoratedImage(item.coverUrl!, 1.0) : SizedBox(),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Expanded(
                      child: const HighlightText(
                        'Fake News',
                        highlightColor: Color(0xFFfcd7da),
                        textColor: Color(0xFF9e0313),
                      ),
                    ),
                    IconButton(onPressed: () {}, icon: LineIcon.bookmark())
                  ]),
                  Text('- ${item.title}',
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontFamily: 'SecularOne',
                          )),
                  const SizedBox(height: 8.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Spacer(),
                      const LineIcon.clock(),
                      Text(timeago.format(DateTime(2004))),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () => context.push('/news_details/${item.id}'),
    );
  }
}

Widget decoratedImage(String url, double aspectRatio) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black, width: 1),
    ),
    margin: const EdgeInsets.only(left: 12.0, top: 20.0),
    child: FractionalTranslation(
      translation: const Offset(-0.04, -0.07),
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: Container(
          foregroundDecoration: const BoxDecoration(
            color: Colors.black,
            backgroundBlendMode: BlendMode.saturation,
          ),
          child: Image.network(
            url,
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
  );
}
