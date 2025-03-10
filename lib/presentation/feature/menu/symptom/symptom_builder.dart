// Flutter imports:
// Project imports:
import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/presentation/feature/menu/symptom/cubit/symptom_history_form_cubit.dart';
import 'package:bladderly/presentation/feature/menu/symptom/symptom_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SymptomBuilder extends StatelessWidget {
  const SymptomBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SymptomHistoryFormCubit>(
      create: (_) => SymptomHistoryFormCubit(getScoresStreamUsecase: getIt())..setData(),
      child: const SymptomModal(),
    );
  }
}
