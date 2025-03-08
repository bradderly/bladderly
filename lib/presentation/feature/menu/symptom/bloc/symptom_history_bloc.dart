// Package imports:
// Project imports:
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
    required SaveScoreUsecase saveScoreUsecase,
  })  : _getScoresStreamUsecase = getScoresStreamUsecase,
        _saveScoreUsecase = saveScoreUsecase,
        super(const SymptomHistoryInitial()) {
    on<SymptomHistoryEvent>(
      (event, emit) {},
      transformer: droppable(),
    );
  }

  final GetScoresStreamUsecase _getScoresStreamUsecase;
  final SaveScoreUsecase _saveScoreUsecase;

  Future<void> _getSymptomHistoryFromRepo(SymptomHistory event, Emitter<SymptomHistoryState> emit) async {
    emit(const SymptomHistoryProgress());

    final result = await _getScoresStreamUsecase();

    result.fold(
      (exception) => emit(SymptomHistoryFailure(exception: exception)),
      (success) => emit(const SymptomHistorySuccess()),
    );
  }
}
