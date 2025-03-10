import 'package:bladderly/presentation/feature/menu/symptom/model/symptom_survery_answer_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'symptom_survey_form_state.dart';

class SymptomSurveyFormCubit extends Cubit<SymptomSurveyFormState> {
  SymptomSurveyFormCubit({
    required int questionCount,
  }) : super(SymptomSurveyFormState(questionCount: questionCount));

  void previousQuestion() {
    emit(state.previousQuestion());
  }

  void nextQuestion() {
    emit(state.nextQuestion());
  }

  void setAnswer(SymptomSurveryAnswerModel answer) {
    emit(state.setAnswer(answer));
  }
}
