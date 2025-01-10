import 'package:flutter/cupertino.dart';

class SuccessColor extends ColorSwatch<int> {
  const SuccessColor()
      : super(
          0xFF002611,
          const {
            10: Color(0xFFE8FCF1),
            20: Color(0xFFA5E1BF),
            40: Color(0xFF419E6A),
            60: Color(0xFF00632B),
            80: Color(0xFF00401C),
            100: Color(0xFF002611),
          },
        );

  Color get shade10 => this[10]!;

  Color get shade20 => this[20]!;

  Color get shade40 => this[40]!;

  Color get shade60 => this[60]!;

  Color get shade80 => this[80]!;

  Color get shade100 => this[100]!;
}
