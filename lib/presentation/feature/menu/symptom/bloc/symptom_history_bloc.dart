// Package imports:
// Project imports:
import 'package:bladderly/domain/usecase/get_scores_server_usecase.dart';
import 'package:bladderly/domain/usecase/get_scores_stream_usecase.dart';
import 'package:bladderly/domain/usecase/save_score_usecase.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'symptom_history_event.dart';
part 'symptom_history_state.dart';

class SymptomHistoryBloc extends Bloc<SymptomHistoryEvent, SymptomHistoryState> {
  SymptomHistoryBloc({
    required GetScoresStreamUsecase getScoresStreamUsecase,
    required GetScoresServerUsecase getScoresServerUsecase,
    required SaveScoreUsecase saveScoreUsecase,
  })  : _getScoresStreamUsecase = getScoresStreamUsecase,
        _getScoresServerUsecase = getScoresServerUsecase,
        _saveScoreUsecase = saveScoreUsecase,
        super(const SymptomHistoryInitial()) {
    on<SymptomHistoryEvent>(
      (event, emit) => switch (event) {
        SymptomHistory() => _getSymptomHistoryFromServer(event, emit),
      },
      transformer: droppable(),
    );
  }

  final GetScoresStreamUsecase _getScoresStreamUsecase;
  final GetScoresServerUsecase _getScoresServerUsecase;
  final SaveScoreUsecase _saveScoreUsecase;

  Future<void> _getSymptomHistoryFromServer(SymptomHistory event, Emitter<SymptomHistoryState> emit) async {
    emit(const SymptomHistoryProgress());

    final result = await _getScoresServerUsecase(userId: event.userId);
    result.fold(
      (exception) => emit(SymptomHistoryFailure(exception: exception)),
      (scores) async {
        // await _saveScoreUsecase(scores: scores);
        emit(const SymptomHistorySuccess());
      },
    );
  }

  Future<void> _getSymptomHistoryFromRepo(SymptomHistory event, Emitter<SymptomHistoryState> emit) async {
    emit(const SymptomHistoryProgress());

    final result = await _getScoresStreamUsecase();

    result.fold(
      (exception) => emit(SymptomHistoryFailure(exception: exception)),
      (success) => emit(const SymptomHistorySuccess()),
    );
  }
}
