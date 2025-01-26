import 'package:bradderly/presentation/common/cubit/locale_cubit.dart';
import 'package:bradderly/presentation/common/locale/app_locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension StringExtension on String {
  String tr(BuildContext context) {
    return Translation().translate(key: this, locale: context.watch<AppLocaleCubit>().state);
  }
}
