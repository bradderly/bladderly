part of 'symptom_survey_bloc.dart';

sealed class SymptomSurveyEvent extends Equatable {
  const SymptomSurveyEvent();

  @override
  List<Object> get props => [];
}

class SymptomSurveySubmit extends SymptomSurveyEvent {
  const SymptomSurveySubmit({
    required this.userId,
    required this.scoreType,
    required this.answers,
  });

  final String userId;
  final ScoreType scoreType;
  final List<int> answers;

  @override
  List<Object> get props => [
        userId,
        scoreType,
        answers,
      ];
}
