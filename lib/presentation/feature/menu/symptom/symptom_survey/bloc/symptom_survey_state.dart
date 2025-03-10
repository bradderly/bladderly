part of 'symptom_survey_bloc.dart';

sealed class SymptomSurveyState extends Equatable {
  const SymptomSurveyState();

  @override
  List<Object> get props => [];
}

final class SymptomSurveyInitial extends SymptomSurveyState {
  const SymptomSurveyInitial();
}

final class SymptomSurveyProgress extends SymptomSurveyState {
  const SymptomSurveyProgress();
}

final class SymptomSurveySuccess extends SymptomSurveyState {
  const SymptomSurveySuccess();
}

final class SymptomSurveyFailure extends SymptomSurveyState {
  const SymptomSurveyFailure({
    required this.exception,
  });

  final Exception exception;

  @override
  List<Object> get props => [
        ...super.props,
        exception,
      ];
}
