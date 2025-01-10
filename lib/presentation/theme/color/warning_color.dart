import 'package:flutter/cupertino.dart';

class WarningColor extends ColorSwatch<int> {
  const WarningColor()
      : super(
          0xFF4D2900,
          const {
            10: Color(0XFFFFF5D5),
            20: Color(0xFFFFDE81),
            40: Color(0xFFEFB008),
            60: Color(0xFF976400),
            80: Color(0xFF724B00),
            100: Color(0xFF4D2900),
          },
        );

  Color get shade10 => this[10]!;

  Color get shade20 => this[20]!;

  Color get shade40 => this[40]!;

  Color get shade60 => this[60]!;

  Color get shade80 => this[80]!;

  Color get shade100 => this[100]!;
}
