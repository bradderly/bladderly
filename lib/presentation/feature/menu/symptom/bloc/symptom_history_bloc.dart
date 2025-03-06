// Package imports:
// Project imports:
import 'package:bladderly/domain/usecase/get_scores_stream_usecase.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'symptom_history_event.dart';
part 'symptom_history_state.dart';

class SymptomHistoryBloc extends Bloc<SymptomHistoryEvent, SymptomHistoryState> {
  SymptomHistoryBloc({
    required GetScoresStreamUsecase getScoresStreamUsecase,
  })  : _getScoresStreamUsecase = getScoresStreamUsecase,
        super(const SymptomHistoryInitial()) {
    on<SymptomHistoryEvent>(
      (event, emit) => switch (event) {
        SymptomHistory() => _getSymptomHistoryhistory(event, emit),
      },
      transformer: droppable(),
    );
  }

  final GetScoresStreamUsecase _getScoresStreamUsecase;

  Future<void> _getSymptomHistoryhistory(SymptomHistory event, Emitter<SymptomHistoryState> emit) async {
    emit(const SymptomHistoryProgress());

    print('LOGTAG -1');
    final result = await _getScoresStreamUsecase();

    print('LOGTAG 1111$result');
    result.fold(
      (exception) => emit(SymptomHistoryFailure(exception: exception)),
      (success) => emit(const SymptomHistorySuccess()),
    );
  }
}
