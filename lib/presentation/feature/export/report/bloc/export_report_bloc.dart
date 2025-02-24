import 'package:bradderly/domain/usecase/send_histories_export_reason_usecase.dart';
import 'package:bradderly/presentation/feature/export/report/model/export_report_reason_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'export_report_event.dart';
part 'export_report_state.dart';

class ExportReportBloc extends Bloc<ExportReportEvent, ExportReportState> {
  ExportReportBloc({
    required SendHistoriesExportReasonUsecase sendHistoriesExportReasonUsecase,
  })  : _sendHistoriesExportReasonUsecase = sendHistoriesExportReasonUsecase,
        super(const ExportReportInitial()) {
    on<ExportReportSelectReason>(_onSelectReason);
    on<ExportReportSendReason>(_onSendReason);
  }

  final SendHistoriesExportReasonUsecase _sendHistoriesExportReasonUsecase;

  void _onSelectReason(ExportReportSelectReason event, Emitter<ExportReportState> emit) {
    emit(ExportReportSelectReasonSuccess(reasonModel: event.reasonModel));
  }

  Future<void> _onSendReason(ExportReportSendReason event, Emitter<ExportReportState> emit) async {
    emit(ExportReportSendReasonInProgress(reasonModel: state.reasonModel));

    final result = await _sendHistoriesExportReasonUsecase(
      hashId: event.hashId,
      clinicInformation: switch (state.reasonModel) {
        final ExportReportShareClinicReason reasonModel => reasonModel.clinicInformation,
        _ => null,
      },
      doctorName: switch (state.reasonModel) {
        final ExportReportShareClinicReason reasonModel => reasonModel.doctorName,
        _ => null,
      },
    );

    result.fold(
      (exception) => emit(ExportReportSendReasonFailure(reasonModel: state.reasonModel, exception: exception)),
      (_) => emit(ExportReportSendReasonSuccess(reasonModel: state.reasonModel)),
    );
  }
}
