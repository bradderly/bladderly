part of 'export_report_bloc.dart';

sealed class ExportReportState extends Equatable {
  const ExportReportState({
    required this.reasonModel,
  });

  final ExportReportReasonModel reasonModel;

  @override
  List<Object> get props => [
        reasonModel,
      ];
}

final class ExportReportInitial extends ExportReportState {
  const ExportReportInitial() : super(reasonModel: const ExportReportReasonModel.noReason());
}

final class ExportReportSelectReasonSuccess extends ExportReportState {
  const ExportReportSelectReasonSuccess({
    required super.reasonModel,
  });
}

final class ExportReportSendReasonInProgress extends ExportReportState {
  const ExportReportSendReasonInProgress({
    required super.reasonModel,
  });
}

final class ExportReportSendReasonSuccess extends ExportReportState {
  const ExportReportSendReasonSuccess({
    required super.reasonModel,
  });
}

final class ExportReportSendReasonFailure extends ExportReportState {
  const ExportReportSendReasonFailure({
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
