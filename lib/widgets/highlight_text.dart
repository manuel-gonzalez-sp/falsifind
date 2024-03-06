import 'package:flutter/material.dart';

class HighlightText extends StatelessWidget {
  const HighlightText(this.text, {super.key, this.textColor, this.highlightColor});

  final String text;
  final Color? textColor;
  final Color? highlightColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        color: highlightColor ?? theme.colorScheme.tertiary,
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 0.0),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: FractionalTranslation(
          translation: const Offset(0.0, -0.2),
          child: Text(
            text.toUpperCase(),
            style: theme.textTheme.titleMedium?.copyWith(
              fontFamily: 'SecularOne',
              color: textColor ?? Colors.black,
              height: 0.8,
            ),
          ),
        ),
      ),
    );
  }
}
