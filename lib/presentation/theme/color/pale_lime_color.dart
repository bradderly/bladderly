// Flutter imports:
import 'package:flutter/material.dart';

class PaleLimeColor extends ColorSwatch<int> {
  const PaleLimeColor()
      : super(
          0xFF7F7C40,
          const {
            5: Color(0xFFF9FBEE),
            10: Color(0xFFEFF5D3),
            20: Color(0xFFE5EFB7),
            30: Color(0xFFDBE99B),
            40: Color(0xFFD3E484),
            50: Color(0xFFCCE071),
            60: Color(0xFFBECE68),
            70: Color(0xFFADB85D),
            80: Color(0xFF9CA152),
            90: Color(0xFF7F7C40),
          },
        );

  Color get shade5 => this[5]!;

  Color get shade10 => this[10]!;

  Color get shade20 => this[20]!;

  Color get shade30 => this[30]!;

  Color get shade40 => this[40]!;

  Color get shade50 => this[50]!;

  Color get shade60 => this[60]!;

  Color get shade70 => this[70]!;

  Color get shade80 => this[80]!;

  Color get shade90 => this[90]!;
}
