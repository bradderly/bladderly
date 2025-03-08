// Flutter imports:
// Project imports:
import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/domain/usecase/get_scores_server_usecase.dart';
import 'package:bladderly/domain/usecase/get_scores_stream_usecase.dart';
import 'package:bladderly/domain/usecase/save_score_usecase.dart';
import 'package:bladderly/presentation/feature/menu/symptom/bloc/symptom_history_bloc.dart';
import 'package:bladderly/presentation/feature/menu/symptom/cubit/symptom_history_form_cubit.dart';
import 'package:bladderly/presentation/feature/menu/symptom/symptom_modal.dart';
import 'package:flutter/widgets.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

class SymptomBuilder extends StatelessWidget {
  const SymptomBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SymptomHistoryFormCubit>(
          create: (context) => SymptomHistoryFormCubit(getScoresStreamUsecase: getIt<GetScoresStreamUsecase>()),
        ),
        BlocProvider<SymptomHistoryBloc>(
          create: (context) => SymptomHistoryBloc(
            getScoresStreamUsecase: getIt<GetScoresStreamUsecase>(),
            getScoresServerUsecase: getIt<GetScoresServerUsecase>(),
            saveScoreUsecase: getIt<SaveScoreUsecase>(),
          ),
        ),
      ],
      child: const SymptomModal(),
    );
  }
}
