// Flutter imports:
// Project imports:
import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/domain/usecase/get_scores_stream_usecase.dart';
import 'package:bladderly/presentation/feature/symptom/scores/cubit/symptom_scores_form_cubit.dart';
import 'package:bladderly/presentation/feature/symptom/scores/symptom_scores_view.dart';
import 'package:flutter/widgets.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

class SymptomScoresBuilder extends StatelessWidget {
  const SymptomScoresBuilder({
    super.key,
    this.showIpssList,
    this.showOabssList,
  });

  final bool? showIpssList;
  final bool? showOabssList;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SymptomScoresFormCubit>(
      create: (_) => SymptomScoresFormCubit(getScoresStreamUsecase: getIt<GetScoresStreamUsecase>())..setData(),
      child: const SymptomScoresView(),
    );
  }
}
