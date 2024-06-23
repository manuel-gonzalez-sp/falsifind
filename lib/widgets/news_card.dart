import 'package:falsifind/config/app_router.dart';
import 'package:falsifind/config/app_theme.dart';
import 'package:falsifind/models/news_item.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';

class NewsCard extends StatelessWidget {
  const NewsCard(this.item, {super.key});

  final NewsItem item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => appRouter.push('/news_details', extra: item.url),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.outline)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(children: [
                        Text(
                          item.url.host,
                          textAlign: TextAlign.left,
                          style: const TextStyle(color: AppColors.accent, height: 2),
                        ),
                        Text(
                          ' - ${item.dateString()}',
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.secondary),
                        ),
                      ]),
                      Text(
                        item.title,
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 2),
                      if (item.truthness != null)
                        Row(children: [
                          item.isTrue! ? const LineIcon.thumbsUp(color: AppColors.success) : const LineIcon.thumbsDown(color: AppColors.danger),
                          item.isTrue!
                              ? Text(
                                  '${(item.truthness! * 100.0).toInt()}% Verdadero',
                                  style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.success),
                                )
                              : Text(
                                  '${(100.0 - item.truthness! * 100.0).toInt()}% Falso',
                                  style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.danger),
                                ),
                        ]),
                    ],
                  ),
                ),
                if (item.coverUrl != null)
                  Center(
                    child: Container(
                      width: 80,
                      height: 80,
                      margin: const EdgeInsets.only(left: 8.0),
                      foregroundDecoration: const BoxDecoration(
                        color: Colors.black,
                        backgroundBlendMode: BlendMode.saturation,
                      ),
                      child: Image.network(item.coverUrl!.toString(), fit: BoxFit.cover),
                    ),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
