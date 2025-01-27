import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bradderly/domain/usecase/export_histories_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'export_event.dart';
part 'export_state.dart';

class ExportBloc extends Bloc<ExportEvent, ExportState> {
  ExportBloc({
    required ExportHistoriesUsecase exportHistoriesUsecase,
  })  : _exportHistoriesUsecase = exportHistoriesUsecase,
        super(const ExportInitial()) {
    on<ExportExportHistories>(_onExport, transformer: droppable());
  }

  final ExportHistoriesUsecase _exportHistoriesUsecase;

  Future<void> _onExport(ExportExportHistories event, Emitter<ExportState> emit) async {
    emit(ExportExportHistoriesInProgress(selectedDates: state.selectedDates));

    await Future<void>.delayed(const Duration(seconds: 1));

    final result = await _exportHistoriesUsecase(
      email: event.email,
      dates: state.selectedDates,
    );

    result.fold(
      (exception) => emit(ExportExportHistoriesFailure(selectedDates: state.selectedDates, exception: exception)),
      (_) => emit(ExportExportHistoriesSuccess(selectedDates: state.selectedDates)),
    );
  }
}
