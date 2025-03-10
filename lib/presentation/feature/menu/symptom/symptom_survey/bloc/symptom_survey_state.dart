part of 'symptom_survey_bloc.dart';

sealed class SymptomSurveyState extends Equatable {
  const SymptomSurveyState();

  @override
  List<Object> get props => [];
}

final class SymptomSurveyInitial extends SymptomSurveyState {
  const SymptomSurveyInitial();
}

final class SymptomSurveySubmitInProgress extends SymptomSurveyState {
  const SymptomSurveySubmitInProgress();
}

final class SymptomSurveySubmitSuccess extends SymptomSurveyState {
  const SymptomSurveySubmitSuccess({
    required this.score,
  });

  final Score score;

  @override
  List<Object> get props => [
        ...super.props,
        score,
      ];
}

final class SymptomSurveySubmitFailure extends SymptomSurveyState {
  const SymptomSurveySubmitFailure({
    required this.exception,
  });

  final Exception exception;

  @override
  List<Object> get props => [
        ...super.props,
        exception,
      ];
}
