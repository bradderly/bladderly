import 'dart:async';

import 'package:bladderly/domain/model/histories.dart';
import 'package:bladderly/domain/usecase/get_histories_stream_usecase.dart';
import 'package:bladderly/presentation/feature/diary/diary/model/diary_history_model.dart';
import 'package:bladderly/presentation/feature/diary/diary/model/diary_intake_summary_model.dart';
import 'package:bladderly/presentation/feature/diary/diary/model/diary_voding_summary_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'diary_state.dart';

class DiaryCubit extends Cubit<DiaryState> {
  DiaryCubit({
    required DateTime dateTime,
    required GetHistoriesStreamUsecase getHistoriesStreamUsecase,
  })  : _getHistoriesStreamUsecase = getHistoriesStreamUsecase,
        super(DiaryState(dateTime: dateTime)) {
    subscribe(dateTime);
  }

  final GetHistoriesStreamUsecase _getHistoriesStreamUsecase;

  StreamSubscription<Histories>? _subscription;

  void subscribe(DateTime dateTime) {
    _clearSubscription();

    _getHistoriesStreamUsecase(userId: 'ydu3328@naver.com', dateTime: DateUtils.dateOnly(dateTime)).fold(
      (l) => null,
      (r) => _subscription = r.listen((histories) => _listener(dateTime: dateTime, histories: histories)),
    );
  }

  void _listener({
    required DateTime dateTime,
    required Histories histories,
  }) {
    if (isClosed) return;

    emit(
      DiaryState(
        dateTime: dateTime,
        diaryVoidingSummaryModel: DiaryVoidingSummaryModel.fromDomain(histories.voidings),
        diaryIntakeSummaryModel: DiaryIntakeSummaryModel.fromDomain(histories.intakes),
        diaryHistoryModels: histories.map(DiaryHistoryModel.fromDomain).toList(),
      ),
    );
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
