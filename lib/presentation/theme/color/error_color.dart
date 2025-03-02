// Flutter imports:
import 'package:flutter/cupertino.dart';

class ErrorColor extends ColorSwatch<int> {
  const ErrorColor()
      : super(
          0xFFB00020,
          const {
            10: Color(0xFFFFEBEB),
            20: Color(0xFFFC9595),
            40: Color(0xFFD83232),
            60: Color(0xFFB01212),
            80: Color(0xFF8C0000),
            100: Color(0xFF660000),
          },
        );
}
