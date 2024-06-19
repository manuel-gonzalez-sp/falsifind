import 'package:falsifind/config/app_router.dart';
import 'package:falsifind/config/app_theme.dart';
import 'package:falsifind/models/news_item.dart';
import 'package:falsifind/widgets/versus_line.dart';
import 'package:flutter/material.dart';

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
          border: Border(bottom: BorderSide(color: AppColors.secondary)),
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
                      if (item.siteName() != null)
                        Text(
                          item.siteName()!,
                          textAlign: TextAlign.left,
                          style: const TextStyle(color: Color(0xFF80acf2), height: 2),
                        ),
                      Text(
                        item.title,
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                        item.dateString(),
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.secondary),
                      ),
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
                      child: Image.network(item.coverUrl!, fit: BoxFit.cover),
                    ),
                  )
              ],
            ),
            const SizedBox(height: 2),
            if (item.truthness != null) VersusLine(item.truthness!),
            // if (item.truthness != null)
            //   Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            //     item.truthness! > 0.5
            //         ? LineIcon.thumbsUp(
            //             color: AppColors.success,
            //           )
            //         : LineIcon.thumbsDown(color: AppColors.danger),
            //     Text(
            //       item.truthness! > 0.5 ? '${item.truthness}% Verdadero' : '${(1 - item.truthness!) * 100}% Falso',
            //       style: TextStyle(color: item.truthness! > 0.5 ? AppColors.success : AppColors.danger),
            //       textAlign: TextAlign.end,
            //     ),
            //   ]),
          ],
        ),
      ),
    );
  }
}



// import 'package:falsifind/models/news_item.dart';
// import 'package:falsifind/widgets/highlight_text.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:line_icons/line_icon.dart';
// import 'package:timeago/timeago.dart' as timeago;

// class NewsCard extends StatelessWidget {
//   const NewsCard(this.item, {super.key});

//   final NewsItem item;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
//         decoration: BoxDecoration(
//           color: Theme.of(context).colorScheme.background,
//           border: const Border(bottom: BorderSide(color: Colors.black12)),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const HighlightText(
//               'Fake News',
//               highlightColor: Color(0xFFfcd7da),
//               textColor: Color(0xFF9e0313),
//             ),
//             Text('- ${item.title}',
//                 textAlign: TextAlign.start,
//                 style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//                       fontFamily: 'SecularOne',
//                     )),
//             const SizedBox(height: 4.0),
//             if (item.coverUrl != null)
//               Container(
//                 decoration: BoxDecoration(
//                   //color: Colors.black12,
//                   border: Border.all(color: Colors.black, width: 1.5),
//                 ),
//                 margin: const EdgeInsets.only(left: 12.0, top: 20.0),
//                 child: FractionalTranslation(
//                   translation: const Offset(-0.025, -0.065),
//                   child: AspectRatio(
//                       aspectRatio: 16.0 / 9.0,
//                       child: Container(
//                         foregroundDecoration: const BoxDecoration(
//                           color: Colors.black,
//                           backgroundBlendMode: BlendMode.saturation,
//                         ),
//                         child: Image.network(
//                           item.coverUrl!,
//                           fit: BoxFit.cover,
//                         ),
//                       )),
//                 ),
//               ),
//             const SizedBox(height: 8.0),
//             Text(
//               item.content,
//               maxLines: 4,
//               overflow: TextOverflow.ellipsis,
//               softWrap: true,
//             ),
//             const SizedBox(height: 12.0),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 const Spacer(),
//                 const LineIcon.clock(),
//                 Text(timeago.format(item.date)),
//               ],
//             ),
//           ],
//         ),
//       ),
//       onTap: () => context.push('/news_details/${item.id}'),
//     );
//   }
// }
