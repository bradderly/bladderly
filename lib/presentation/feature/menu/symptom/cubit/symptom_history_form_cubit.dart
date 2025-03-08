// Package imports:
import 'dart:async';

import 'package:bladderly/domain/model/scores.dart';
import 'package:bladderly/domain/usecase/get_scores_stream_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'symptom_history_form_state.dart';

class SymptomHistoryFormCubit extends Cubit<SymptomHistoryFormState> {
  SymptomHistoryFormCubit({
    required GetScoresStreamUsecase getScoresStreamUsecase,
  })  : _getScoresStreamUsecase = getScoresStreamUsecase,
        super(const SymptomHistoryFormState());

  final GetScoresStreamUsecase _getScoresStreamUsecase;

  StreamSubscription<Scores>? _subscription;

  void setData() {
    _getScoresStreamUsecase().then(
      (result) => result.fold(
        (l) => null,
        (r) => _subscription = r.listen(_listener),
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

  void _listener(Scores scores) {
    if (isClosed) return;

    emit(
      SymptomHistoryFormState(
        scores: scores,
      ),
    );
  }
}
