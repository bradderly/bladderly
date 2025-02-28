part of 'export_report_bloc.dart';

sealed class ExportReportEvent extends Equatable {
  const ExportReportEvent();

  @override
  List<Object> get props => [];
}

class ExportReportSelectReason extends ExportReportEvent {
  const ExportReportSelectReason({
    required this.reasonModel,
  });

  final ExportReportReasonModel reasonModel;

  @override
  List<Object> get props => [
        reasonModel,
      ];
}

class ExportReportSendReason extends ExportReportEvent {
  const ExportReportSendReason({
    required this.userId,
  });

  final String userId;

  @override
  List<Object> get props => [
        userId,
      ];
}
