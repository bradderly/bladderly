// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:bladderly/domain/model/unit.dart';
import 'package:bladderly/presentation/common/cubit/locale_cubit.dart';
import 'package:bladderly/presentation/common/cubit/unit_cubit.dart';
import 'package:bladderly/presentation/common/locale/app_locale.dart';
import 'package:bladderly/presentation/theme/color/color_theme.dart';
import 'package:bladderly/presentation/theme/shadow/shadow_theme.dart';
import 'package:bladderly/presentation/theme/text_style/text_style_theme.dart';

extension BuildContextExtension on BuildContext {
  BladderlyColorTheme get colorTheme => Theme.of(this).extension<BladderlyColorTheme>()!;

  BladderlyTextStyleTheme get textStyleTheme => Theme.of(this).extension<BladderlyTextStyleTheme>()!;

  Unit get unit => select<UnitCubit, Unit>((cubit) => cubit.state);

  String get unitName => select<UnitCubit, String>((cubit) => cubit.state.name);

  int unitValue(int value) => select<UnitCubit, int>((cubit) => cubit.state.parseFromMl(value));

  BladderlyShadowTheme get shadowTheme => Theme.of(this).extension<BladderlyShadowTheme>()!;

  AppLocale get locale => watch<AppLocaleCubit>().state;
}
