import 'package:flutter/cupertino.dart';

class WhiteColor extends ColorSwatch<int> {
  const WhiteColor()
      : super(
          0xFFC4C4C4,
          const {
            0: Color(0xFFC4C4C4),
            10: Color(0xFFC4C4C4),
            20: Color(0xFFF5F5F5),
            30: Color(0xFFF1F1F1),
            40: Color(0xFFDEDEDE),
            50: Color(0xFFC3C3C3),
            60: Color(0xFF979797),
            70: Color(0xFF818181),
            80: Color(0xFF606060),
            90: Color(0xFF3D3D3D),
          },
        );

  Color get shade0 => this[0]!;

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
