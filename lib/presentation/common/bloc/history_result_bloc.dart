import 'package:bladderly/domain/usecase/get_history_result_usecase.dart';
import 'package:bladderly/domain/usecase/refresh_history_result_usecase.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'history_result_event.dart';
part 'history_result_state.dart';

class HistoryResultBloc extends Bloc<HistoryResultEvent, HistoryResultState> {
  HistoryResultBloc({
    required GetHistoryResultUsecase getHistoryProcessingResultUsecase,
    required RefreshHistoryResultUsecase refreshHistoryResultUsecase,
  })  : _getHistoryResultUsecase = getHistoryProcessingResultUsecase,
        _refreshHistoryResultUsecase = refreshHistoryResultUsecase,
        super(HistoryResultInitial()) {
    on<HistoryResultGet>(_getHistoryResult, transformer: concurrent());
    on<HistoryResultRefresh>(_refreshHistoryResult, transformer: concurrent());
  }

  final GetHistoryResultUsecase _getHistoryResultUsecase;
  final RefreshHistoryResultUsecase _refreshHistoryResultUsecase;

  Future<void> _getHistoryResult(
    HistoryResultGet event,
    Emitter<HistoryResultState> emit,
  ) async {
    emit(const HistoryResultGetInProgress());

    final result = await _getHistoryResultUsecase(
      historyId: event.historyId,
      userId: event.userId,
    );

    result.fold(
      (exception) => emit(HistoryResultGetFailure(exception: exception)),
      (history) => emit(const HistoryResultGetSuccess()),
    );
  }

  Future<void> _refreshHistoryResult(
    HistoryResultRefresh event,
    Emitter<HistoryResultState> emit,
  ) async {
    emit(const HistoryResultRefreshInProgress());

    final result = await _refreshHistoryResultUsecase(
      historyId: event.historyId,
      userId: event.userId,
    );

    result.fold(
      (exception) => emit(
        HistoryResultRefreshFailure(
          exception: exception,
        ),
      ),
      (history) => emit(const HistoryResultRefreshSuccess()),
    );
  }
}
