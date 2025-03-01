// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';

enum DiaryHistoryTypeModel {
  voiding,
  intake,
  leakage,
  ;

  String get text {
    return switch (this) {
      voiding => 'Voiding',
      intake => 'Intake',
      leakage => 'Leakage',
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
