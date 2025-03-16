// Package imports:
import 'dart:async';

import 'package:bladderly/domain/model/scores.dart';
import 'package:bladderly/domain/usecase/get_scores_stream_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'symptom_scores_state.dart';

class SymptomScoresCubit extends Cubit<SymptomScoresState> {
  SymptomScoresCubit({
    required GetScoresStreamUsecase getScoresStreamUsecase,
  })  : _getScoresStreamUsecase = getScoresStreamUsecase,
        super(const SymptomScoresState()) {
    _listen();
  }

  final GetScoresStreamUsecase _getScoresStreamUsecase;

  StreamSubscription<Scores>? _subscription;

  void _listen() {
    _getScoresStreamUsecase().then(
      (result) => result.fold(
        (l) => null,
        (r) => _subscription = r.listen(_listener),
      ),
    );
  }

  void expandIpss() {
    emit(state.copyWith(isExpandedIpss: true));
  }

  void collapseIpss() {
    emit(state.copyWith(isExpandedIpss: false));
  }

  void toggleIpss() {
    return state.isExpandedIpss ? collapseIpss() : expandIpss();
  }

  void expandOabss() {
    emit(state.copyWith(isExpandedOabss: true));
  }

  void collapseOabss() {
    emit(state.copyWith(isExpandedOabss: false));
  }

  void toggleOabss() {
    return state.isExpandedOabss ? collapseOabss() : expandOabss();
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

  void _listener(Scores scores) {
    if (isClosed) return;

    emit(state.copyWith(scores: scores));
  }
}
