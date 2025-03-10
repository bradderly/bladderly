import 'package:flutter/material.dart';

class TextSizeUtil {
  const TextSizeUtil._();

  static Size getSize({
    required String text,
    required TextStyle textStyle,
  }) {
    final textPainter = TextPainter(text: TextSpan(text: text, style: textStyle), textDirection: TextDirection.ltr)
      ..layout();

    return textPainter.size;
  }
}
