import 'package:flutter/material.dart';

class NeutralColor extends ColorSwatch<int> {
  const NeutralColor()
      : super(
          0xFF0F1A2A,
          const <int, Color>{
            0: Color(0xFFFFFFFF),
            1: Color(0xFFFFFFFF),
            2: Color(0xFFF5F5F5),
            3: Color(0xFFF1F1F1),
            4: Color(0xFFDEDEDE),
            5: Color(0xFFC3C3C3),
            6: Color(0xFF979797),
            7: Color(0xFF818181),
            8: Color(0xFF606060),
            9: Color(0xFF3D3D3D),
            10: Color(0xFF000000),
          },
        );

  Color get shade0 => this[0]!;

  Color get shade1 => this[1]!;

  Color get shade2 => this[2]!;

  Color get shade3 => this[3]!;

  Color get shade4 => this[4]!;

  Color get shade5 => this[5]!;

  Color get shade6 => this[6]!;

  Color get shade7 => this[7]!;

  Color get shade8 => this[8]!;

  Color get shade9 => this[9]!;

  Color get shade10 => this[10]!;
}
