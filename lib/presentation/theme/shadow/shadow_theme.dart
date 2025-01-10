import 'package:flutter/material.dart';

class BladderlyShadowTheme extends ThemeExtension<BladderlyShadowTheme> {
  final shadow1 = <BoxShadow>[
    const BoxShadow(
      color: Color(0x1E5D3F33),
      blurRadius: 5,
      offset: Offset(0, 2),
    ),
    const BoxShadow(
      color: Color(0x265C3F32),
      blurRadius: 8,
      offset: Offset(0, 4),
      spreadRadius: 3,
    ),
  ];

  final shadow3 = <BoxShadow>[
    const BoxShadow(
      color: Color(0x1EF4F2EC),
      blurRadius: 5,
      offset: Offset(0, 2),
    ),
    const BoxShadow(
      color: Color(0x1C615637),
      blurRadius: 8,
      offset: Offset(0, 4),
      spreadRadius: 3,
    ),
  ];

  @override
  ThemeExtension<BladderlyShadowTheme> copyWith() {
    return this;
  }

  @override
  ThemeExtension<BladderlyShadowTheme> lerp(covariant ThemeExtension<BladderlyShadowTheme>? other, double t) {
    return this;
  }
}
