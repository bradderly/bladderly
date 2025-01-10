import 'package:flutter/cupertino.dart';

class VermilionColor {
  const VermilionColor()
      : primary = const VermilionPrimaryColor(),
        secondary = const VermilionSecondaryColor();

  final VermilionPrimaryColor primary;
  final VermilionSecondaryColor secondary;
}

class VermilionPrimaryColor extends ColorSwatch<int> {
  const VermilionPrimaryColor()
      : super(
          0xFFDC5822,
          const {
            30: Color(0xFFF69164),
            40: Color(0xFFF57A44),
            50: Color(0xFFF46628),
            60: Color(0xFFE95F25),
            70: Color(0xFFDC5822),
          },
        );

  Color get shade30 => this[30]!;

  Color get shade40 => this[40]!;

  Color get shade50 => this[50]!;

  Color get shade60 => this[60]!;

  Color get shade70 => this[70]!;
}

class VermilionSecondaryColor extends ColorSwatch<int> {
  const VermilionSecondaryColor()
      : super(
          0xFFF57A44,
          const {
            5: Color(0xFFFAEAE6),
            10: Color(0xFFFACEBB),
            20: Color(0xFFF8AF90),
            30: Color(0xFFF69164),
            40: Color(0xFFF57A44),
          },
        );

  Color get shade5 => this[5]!;

  Color get shade10 => this[10]!;

  Color get shade20 => this[20]!;

  Color get shade30 => this[30]!;

  Color get shade40 => this[40]!;
}
