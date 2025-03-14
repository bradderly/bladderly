// Package imports:
// Project imports:
import 'package:bladderly/domain/usecase/send_histories_export_reason_usecase.dart';
import 'package:bladderly/presentation/feature/export/term/model/export_report_reason_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'export_survey_event.dart';
part 'export_survey_state.dart';

class ExportSurveyBloc extends Bloc<ExportSurveyEvent, ExportSurveyState> {
  ExportSurveyBloc({
    required SendHistoriesExportReasonUsecase sendHistoriesExportReasonUsecase,
  })  : _sendHistoriesExportReasonUsecase = sendHistoriesExportReasonUsecase,
        super(const ExportSurveyInitial()) {
    on<ExportSurveySelectReason>(_onSelectReason);
    on<ExportSurveySendReason>(_onSendReason);
  }

  final SendHistoriesExportReasonUsecase _sendHistoriesExportReasonUsecase;

  void _onSelectReason(ExportSurveySelectReason event, Emitter<ExportSurveyState> emit) {
    emit(ExportSurveySelectReasonSuccess(reasonModel: event.reasonModel));
  }

  Future<void> _onSendReason(ExportSurveySendReason event, Emitter<ExportSurveyState> emit) async {
    emit(ExportSurveySendReasonInProgress(reasonModel: state.reasonModel));

    final result = await _sendHistoriesExportReasonUsecase(
      userId: event.userId,
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
      (exception) => emit(ExportSurveySendReasonFailure(reasonModel: state.reasonModel, exception: exception)),
      (_) => emit(ExportSurveySendReasonSuccess(reasonModel: state.reasonModel)),
    );
  }
}
