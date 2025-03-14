// Package imports:
import 'dart:async';

import 'package:bladderly/domain/usecase/get_history_dates_stream_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'export_dates_state.dart';

class ExportDatesCubit extends Cubit<ExportDatesState> {
  ExportDatesCubit({
    required GetHistoryDatesStreamUsecase getHistoryDatesStreamUsecase,
  })  : _getHistoryDatesStreamUsecase = getHistoryDatesStreamUsecase,
        super(const ExportDatesState());

  final GetHistoryDatesStreamUsecase _getHistoryDatesStreamUsecase;

  StreamSubscription<List<DateTime>>? _subscription;

  void select(DateTime date) {
    final hasDate = state.selectedDates.contains(date);

    if (hasDate && state.selectedDates.length >= 7) {
      return;
    }

    final dates = List<DateTime>.from(state.selectedDates);

    if (hasDate) {
      dates.remove(date);
    } else {
      dates.add(date);
    }

    emit(state.copyWith(selectedDates: dates));
  }

  void subscribe() {
    _clearSubscription();

    _subscription = _getHistoryDatesStreamUsecase().fold(
      (l) => null,
      (r) => r.listen(_listener),
    );
  }

  void _listener(List<DateTime> dates) {
    if (isClosed) return;

    emit(state.copyWith(dates: dates));
  }

  void _clearSubscription() {
    _subscription?.cancel();
    _subscription = null;
  }

  @override
  Future<void> close() {
    _clearSubscription();
    return super.close();
  }
}
