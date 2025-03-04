// Package imports:
// Project imports:
import 'package:bladderly/domain/usecase/get_history_results_usecase.dart';
import 'package:bladderly/domain/usecase/upload_pending_upload_histories_usecase.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_history_event.dart';
part 'main_history_state.dart';

class MainHistoryBloc extends Bloc<MainHistoryEvent, MainHistoryState> {
  MainHistoryBloc({
    required UploadPendingHistoriesUsecase uploadPendingHistoriesUsecase,
    required GetHistoryResultsUsecase getProcessingHistoryResultsUsecase,
  })  : _uploadPendingHistoriesUsecase = uploadPendingHistoriesUsecase,
        _getHistoryResultsUsecase = getProcessingHistoryResultsUsecase,
        super(const MainPendingHistoryInitial()) {
    on<MainHistoryUploadPendingHistories>(_onUploadPendingHistories, transformer: droppable());
    on<MainHistoryGetHistoryResults>(_onGetProcessingHistoryResults, transformer: droppable());
  }

  final UploadPendingHistoriesUsecase _uploadPendingHistoriesUsecase;
  final GetHistoryResultsUsecase _getHistoryResultsUsecase;

  Future<void> _onUploadPendingHistories(
    MainHistoryUploadPendingHistories event,
    Emitter<MainHistoryState> emit,
  ) async {
    emit(const MainHistoryUploadPendingHistoriesInProgress());

    final result = await _uploadPendingHistoriesUsecase(userId: event.userId);

    result.fold(
      (exception) => emit(MainHistoryUploadPendingHistoriesFailure(exception: exception)),
      (_) => emit(const MainHistoryUploadPendingHistoriesSuccess()),
    );
  }

  Future<void> _onGetProcessingHistoryResults(
    MainHistoryGetHistoryResults event,
    Emitter<MainHistoryState> emit,
  ) async {
    emit(const MainHistoryGetHistoryResultsInProgress());

    final result = await _getHistoryResultsUsecase(userId: event.userId);

    result.fold(
      (exception) => emit(MainHistoryGetHistoryResultsFailure(exception: exception)),
      (histories) => emit(const MainHistoryGetHistoryResultsSuccess()),
    );
  }
}
