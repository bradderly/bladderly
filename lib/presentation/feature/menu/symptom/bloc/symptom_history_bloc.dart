// Package imports:
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:bladderly/domain/usecase/symptom_history_usecase.dart';

part 'symptom_history_event.dart';
part 'symptom_history_state.dart';

class SymptomHistoryBloc extends Bloc<SymptomHistoryEvent, SymptomHistoryState> {
  SymptomHistoryBloc({
    required SymptomHistoryUsecase symtomHistoryUsecase,
  })  : _symptomHistory = symtomHistoryUsecase,
        super(const SymptomHistoryInitial()) {
    on<SymptomHistoryEvent>(
      (event, emit) => switch (event) {
        SymptomHistory() => _getSymptomHistoryhistory(event, emit),
      },
      transformer: droppable(),
    );
  }

  final SymptomHistoryUsecase _symptomHistory;

  Future<void> _getSymptomHistoryhistory(SymptomHistory event, Emitter<SymptomHistoryState> emit) async {
    emit(const SymptomHistoryProgress());

    print('LOGTAG -1');
    final result = await _symptomHistory(
      userId: event.userId,
    );

    print('LOGTAG 1111' + result.toString());
    result.fold(
      (exception) => emit(SymptomHistoryFailure(exception: exception)),
      (success) => emit(const SymptomHistorySuccess()),
    );
  }
}
