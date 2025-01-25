import 'package:bradderly/presentation/common/cubit/locale_cubit.dart';
import 'package:bradderly/presentation/common/cubit/unit_cubit.dart';
import 'package:bradderly/presentation/common/locale/app_locale.dart';
import 'package:bradderly/presentation/theme/color/color_theme.dart';
import 'package:bradderly/presentation/theme/shadow/shadow_theme.dart';
import 'package:bradderly/presentation/theme/text_style/text_style_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension BuildContextExtension on BuildContext {
  BladderlyColorTheme get colorTheme => Theme.of(this).extension<BladderlyColorTheme>()!;

  BladderlyTextStyleTheme get textStyleTheme => Theme.of(this).extension<BladderlyTextStyleTheme>()!;

  String get unit => select<UnitCubit, String>((cubit) => cubit.state.name);

  num unitValue(num value) => select<UnitCubit, num>((cubit) => cubit.state.parse(value));

  BladderlyShadowTheme get shadowTheme => Theme.of(this).extension<BladderlyShadowTheme>()!;

  AppLocale get locale => watch<AppLocaleCubit>().state;
}
