import 'dart:async';

import 'package:bradderly/domain/model/histories.dart';
import 'package:bradderly/domain/usecase/get_histories_stream_usecase.dart';
import 'package:bradderly/presentation/feature/main/diary/model/diary_history_model.dart';
import 'package:bradderly/presentation/feature/main/diary/model/diary_intake_summary_model.dart';
import 'package:bradderly/presentation/feature/main/diary/model/diary_voding_summary_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'diary_state.dart';

class DiaryCubit extends Cubit<DiaryState> {
  DiaryCubit({
    required GetHistoriesStreamUsecase getHistoriesStreamUsecase,
  })  : _getHistoriesStreamUsecase = getHistoriesStreamUsecase,
        super(const DiaryState());

  final GetHistoriesStreamUsecase _getHistoriesStreamUsecase;

  StreamSubscription<Histories>? _subscription;

  void subscribe(DateTime dateTime) {
    _clearSubscription();

    _subscription = _getHistoriesStreamUsecase(hashId: 'ydu3328@naver.com', dateTime: DateUtils.dateOnly(dateTime))
        .listen(_listener);
  }

  void _listener(Histories histories) {
    if (isClosed) return;

    emit(
      DiaryState(
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
