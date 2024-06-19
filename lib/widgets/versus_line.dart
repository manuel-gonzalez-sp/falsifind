import 'package:falsifind/config/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';

class VersusLine extends StatelessWidget {
  VersusLine(
    this.progress, {
    super.key,
    String? textLeft,
    String? textRight,
    Color? colorLeft,
    Color? colorRight,
    IconData? iconLeft,
    IconData? iconRight,
  })  : textLeft = textLeft ?? 'Falso',
        textRight = textRight ?? 'Verdadero',
        colorLeft = colorLeft ?? AppColors.danger,
        colorRight = colorRight ?? AppColors.success,
        iconLeft = iconLeft ?? const LineIcon.thumbsDown().icon!,
        iconRight = iconRight ?? const LineIcon.thumbsUp().icon!;

  final double progress;

  final Color colorLeft;
  final Color colorRight;
  final IconData iconLeft;
  final IconData iconRight;
  final String textLeft;
  final String textRight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          Icon(iconLeft, color: colorLeft),
          Expanded(
            child: Text(
              progress > 0.5 ? textLeft : textRight,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(color: progress > 0.5 ? colorLeft : colorRight),
              textAlign: TextAlign.center,
            ),
          ),
          Icon(iconRight, color: colorRight),
        ]),
        LinearProgressIndicator(
          value: progress,
          color: colorLeft,
          backgroundColor: colorRight,
        )
      ],
    );
    // return Stack(
    //   children: [
    //     Container(
    //       height: 4.0,
    //       width: double.infinity,
    //       decoration: BoxDecoration(
    //         color: Colors.grey[300],
    //         borderRadius: BorderRadius.circular(5),
    //       ),
    //     ),
    //     FractionallySizedBox(
    //       widthFactor: progress1,
    //       child: Container(
    //         height: height,
    //         decoration: BoxDecoration(
    //           color: Colors.blue,
    //           borderRadius: progress2 == 0
    //               ? BorderRadius.circular(5)
    //               : BorderRadius.only(
    //                   topLeft: Radius.circular(5),
    //                   bottomLeft: Radius.circular(5),
    //                 ),
    //         ),
    //       ),
    //     ),
    //     FractionallySizedBox(
    //       widthFactor: progress1 + progress2,
    //       child: Container(
    //         height: height,
    //         decoration: BoxDecoration(
    //           color: Colors.green,
    //           borderRadius: BorderRadius.only(
    //             topRight: Radius.circular(5),
    //             bottomRight: Radius.circular(5),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }
}
