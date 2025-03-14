part of 'export_survey_bloc.dart';

sealed class ExportSurveyEvent extends Equatable {
  const ExportSurveyEvent();

  @override
  List<Object> get props => [];
}

class ExportSurveySelectReason extends ExportSurveyEvent {
  const ExportSurveySelectReason({
    required this.reasonModel,
  });

  final ExportReportReasonModel reasonModel;

  @override
  List<Object> get props => [
        reasonModel,
      ];
}

class ExportSurveySendReason extends ExportSurveyEvent {
  const ExportSurveySendReason({
    required this.userId,
  });

  final String userId;

  @override
  List<Object> get props => [
        userId,
      ];
}
