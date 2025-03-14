part of 'export_survey_bloc.dart';

sealed class ExportSurveyState extends Equatable {
  const ExportSurveyState({
    required this.reasonModel,
  });

  final ExportReportReasonModel reasonModel;

  @override
  List<Object> get props => [
        reasonModel,
      ];
}

final class ExportSurveyInitial extends ExportSurveyState {
  const ExportSurveyInitial() : super(reasonModel: const ExportReportReasonModel.noReason());
}

final class ExportSurveySelectReasonSuccess extends ExportSurveyState {
  const ExportSurveySelectReasonSuccess({
    required super.reasonModel,
  });
}

final class ExportSurveySendReasonInProgress extends ExportSurveyState {
  const ExportSurveySendReasonInProgress({
    required super.reasonModel,
  });
}

final class ExportSurveySendReasonSuccess extends ExportSurveyState {
  const ExportSurveySendReasonSuccess({
    required super.reasonModel,
  });
}

final class ExportSurveySendReasonFailure extends ExportSurveyState {
  const ExportSurveySendReasonFailure({
    required super.reasonModel,
    required this.exception,
  });

  final Exception exception;

  @override
  List<Object> get props => [
        ...super.props,
        exception,
      ];
}
