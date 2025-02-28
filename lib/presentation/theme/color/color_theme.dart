// Flutter imports:
import 'package:bladderly/presentation/theme/color/neutral_color.dart';
import 'package:bladderly/presentation/theme/color/pale_lime_color.dart';
import 'package:bladderly/presentation/theme/color/success_color.dart';
import 'package:bladderly/presentation/theme/color/vermilion_color.dart';
import 'package:bladderly/presentation/theme/color/white_color.dart';
import 'package:flutter/material.dart';

class BladderlyColorTheme extends ThemeExtension<BladderlyColorTheme> {
  BladderlyColorTheme();

  final neutral = const NeutralColor();
  final success = const SuccessColor();
  final vermilion = const VermilionColor();
  final paleLime = const PaleLimeColor();
  final white = const WhiteColor();
  final warning = const Color(0xFFFF5D5D);

  @override
  ThemeExtension<BladderlyColorTheme> copyWith() {
    return this;
  }

  @override
  ThemeExtension<BladderlyColorTheme> lerp(ThemeExtension<BladderlyColorTheme>? other, double t) {
    return this;
  }
}
