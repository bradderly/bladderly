import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/presentation/common/cubit/locale_cubit.dart';
import 'package:bladderly/presentation/feature/menu/language/language_view_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageViewBuilder extends StatelessWidget {
  const LanguageViewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppLocaleCubit>(
      create: (_) => getIt<AppLocaleCubit>(),
      child: const LanguageViewModal(),
    );
  }
}
