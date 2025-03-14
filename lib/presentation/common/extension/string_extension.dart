// Flutter imports:
// Project imports:
import 'package:bladderly/presentation/common/cubit/locale_cubit.dart';
import 'package:bladderly/presentation/common/locale/app_locale.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

extension StringExtension on String {
  String tr(
    BuildContext context, {
    AppLocale? appLocale,
  }) {
    return Translation().translate(key: this, locale: appLocale ?? context.watch<AppLocaleCubit>().state);
  }

  String applyWordBreak() {
    return replaceAllMapped(RegExp(r'(\S)(?=\S)'), (m) => '${m[1]}\u200D');
  }

  bool validateEmail() {
    return RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(this);
  }
}
