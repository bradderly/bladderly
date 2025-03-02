// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:bladderly/presentation/common/cubit/locale_cubit.dart';
import 'package:bladderly/presentation/common/locale/app_locale.dart';

extension StringExtension on String {
  String tr(BuildContext context) {
    return Translation().translate(key: this, locale: context.watch<AppLocaleCubit>().state);
  }

  String applyWordBreak() {
    return replaceAllMapped(RegExp(r'(\S)(?=\S)'), (m) => '${m[1]}\u200D');
  }
}
