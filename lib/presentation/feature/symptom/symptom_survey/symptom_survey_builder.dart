// Flutter imports:
// Project imports:
import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/domain/usecase/send_score_result_usecase.dart';
import 'package:bladderly/presentation/feature/symptom/model/symptom_survey_model.dart';
import 'package:bladderly/presentation/feature/symptom/symptom_survey/bloc/symptom_survey_bloc.dart';
import 'package:bladderly/presentation/feature/symptom/symptom_survey/cubit/symptom_survey_form_cubit.dart';
import 'package:bladderly/presentation/feature/symptom/symptom_survey/symptom_survey_view.dart';
import 'package:flutter/widgets.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

class SymptomSurveyBuilder extends StatelessWidget {
  const SymptomSurveyBuilder({super.key, required this.symptomSurveyModel});
  final SymptomSurveyModel symptomSurveyModel;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SymptomSurveyBloc>(
          create: (_) => SymptomSurveyBloc(
            sendScoreResultUsecase: getIt<SendScoreResultUsecase>(),
          ),
        ),
        BlocProvider<SymptomSurveyFormCubit>(
          create: (_) => SymptomSurveyFormCubit(questionCount: symptomSurveyModel.questions.length),
        ),
      ],
      child: SymptomSurveyView(symptomSurveyModel: symptomSurveyModel),
    );
  }
}
