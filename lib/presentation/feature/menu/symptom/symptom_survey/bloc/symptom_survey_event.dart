part of 'symptom_survey_bloc.dart';

sealed class SymptomSurveyEvent extends Equatable {
  const SymptomSurveyEvent();

  @override
  List<Object> get props => [];
}

class SymptomSurvey extends SymptomSurveyEvent {
  const SymptomSurvey({
    required this.userId,
    required this.score,
  });

  final String userId;
  final Score score;

  @override
  List<Object> get props => [
        userId,
        score,
      ];
}
