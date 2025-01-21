import 'package:flutter/material.dart';

enum BeverageTypeModel {
  water,
  caffeine,
  soda,
  juice,
  alcohol,
  others,
  ;

  Color get color {
    return switch (this) {
      water => const Color(0xFF6FE7E7),
      caffeine => const Color(0xFFE7AD6F),
      soda => const Color(0xFF6F8BE7),
      juice => const Color(0xFFE1E76F),
      alcohol => const Color(0xFF95E76F),
      others => const Color(0xFF936FE7),
    };
  }
}
