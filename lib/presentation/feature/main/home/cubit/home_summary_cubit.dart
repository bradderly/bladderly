import 'dart:async';

import 'package:bradderly/domain/model/histories.dart';
import 'package:bradderly/domain/usecase/get_histories_stream_usecase.dart';
import 'package:bradderly/presentation/feature/main/home/model/home_intake_summary_model.dart';
import 'package:bradderly/presentation/feature/main/home/model/home_voiding_summary_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_summary_state.dart';

class HomeSummaryCubit extends Cubit<HomeSummaryState> {
  HomeSummaryCubit({
    required GetHistoriesStreamUsecase getHistoriesStreamUsecase,
  })  : _getHistoriesStreamUsecase = getHistoriesStreamUsecase,
        super(const HomeSummaryState());

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
      HomeSummaryState(
        voidingSummaryModel: HomeVoidingSummaryModel.fromDomain(histories.voidings),
        intakeSummaryModel: HomeIntakeSummaryModel.fromDomain(histories.intakes),
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
