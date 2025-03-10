// Flutter imports:
// Project imports:
import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/domain/usecase/send_score_result_usecase.dart';
import 'package:bladderly/presentation/feature/menu/symptom/symptom_survey/bloc/symptom_survey_bloc.dart';
import 'package:bladderly/presentation/feature/menu/symptom/symptom_survey/symptom_survey_modal.dart';
import 'package:flutter/widgets.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

class SymptomSurveyBuilder extends StatelessWidget {
  const SymptomSurveyBuilder({super.key, required this.symptomType});
  final String symptomType;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SymptomSurveyBloc>(
          create: (_) => SymptomSurveyBloc(
            sendScoreResultUsecase: getIt<SendScoreResultUsecase>(),
          ),
        ),
      ],
      child: SymptomSurveyModal(symptom_type: symptomType),
    );
  }
}
