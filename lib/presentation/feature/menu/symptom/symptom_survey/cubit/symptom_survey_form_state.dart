part of 'symptom_survey_form_cubit.dart';

class SymptomSurveyFormState extends Equatable {
  SymptomSurveyFormState({
    required int questionCount,
  })  : index = 0,
        answers = List<SymptomSurveryAnswerModel?>.unmodifiable(
          List<SymptomSurveryAnswerModel?>.generate(
            questionCount,
            (index) => null,
          ),
        );

  SymptomSurveyFormState._({
    required this.index,
    required List<SymptomSurveryAnswerModel?> answers,
  }) : answers = List<SymptomSurveryAnswerModel?>.unmodifiable(answers);

  final int index;
  final List<SymptomSurveryAnswerModel?> answers;

  SymptomSurveyFormState setAnswer(SymptomSurveryAnswerModel answer) {
    return SymptomSurveyFormState._(
      index: index,
      answers: List<SymptomSurveryAnswerModel?>.from(answers)..[index] = answer,
    );
  }

  SymptomSurveyFormState previousQuestion() {
    return SymptomSurveyFormState._(
      index: index - 1,
      answers: answers,
    );
  }

  SymptomSurveyFormState nextQuestion() {
    return SymptomSurveyFormState._(
      index: index + 1,
      answers: answers,
    );
  }

  bool get hasAnswer => answers[index] != null;

  bool get isLastQuestion => index == answers.length - 1;

  @override
  List<Object> get props => [
        index,
        answers,
      ];
}
