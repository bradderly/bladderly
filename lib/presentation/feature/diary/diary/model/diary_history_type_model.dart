import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/extension/string_extension.dart';
import 'package:flutter/material.dart';

enum DiaryHistoryTypeModel {
  voiding,
  intake,
  leakage,
  ;

  String get text {
    return switch (this) {
      voiding => 'Voiding'.tr,
      intake => 'Intake'.tr,
      leakage => 'Leakage'.tr,
    };
  }

  Color getColor(BuildContext context) {
    return switch (this) {
      voiding => context.colorTheme.vermilion.primary.shade50,
      intake => context.colorTheme.paleLime.shade70,
      leakage => const Color(0xFF606AC9),
    };
  }
}
