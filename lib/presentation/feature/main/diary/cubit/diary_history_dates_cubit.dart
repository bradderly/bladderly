import 'dart:async';

import 'package:bradderly/domain/usecase/get_history_dates_stream_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'diary_history_dates_state.dart';

class DiaryHistoryDatesCubit extends Cubit<DiaryHistoryDatesState> {
  DiaryHistoryDatesCubit({
    required GetHistoryDatesStreamUsecase getHistoryDatesStreamUsecase,
  })  : _getHistoryDatesStreamUsecase = getHistoryDatesStreamUsecase,
        super(const DiaryHistoryDatesState());

  final GetHistoryDatesStreamUsecase _getHistoryDatesStreamUsecase;

  StreamSubscription<List<DateTime>>? _subscription;

  void subscribe() {
    _clearSubscription();

    _subscription = _getHistoryDatesStreamUsecase(hashId: 'ydu3328@naver.com').fold(
      (l) => null,
      (r) => r.listen(_listener),
    );
  }

  void _listener(List<DateTime> dats) {
    if (isClosed) return;

    emit(DiaryHistoryDatesState(dates: dats));
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
