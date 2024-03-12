import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final Color color;
  final double textSize;
  final bool isTitle;
  final int maxLines;

  const TextWidget({
    Key? key,
    required this.text,
    required this.color,
    required this.textSize,
    this.isTitle = false,
    this.maxLines = 10, // Default value set here, no need for re-declaration.
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines, // Ensures the text is limited to the specified number of lines.
      style: TextStyle(
        overflow: TextOverflow.ellipsis, // Truncates with ellipsis if text overflows.
        color: color,
        fontSize: textSize,
        fontWeight: isTitle ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
