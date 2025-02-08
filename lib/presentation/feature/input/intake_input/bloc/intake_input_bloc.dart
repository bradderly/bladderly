import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bradderly/domain/usecase/save_intake_history_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'intake_input_event.dart';
part 'intake_input_state.dart';

class IntakeInputBloc extends Bloc<IntakeInputEvent, IntakeInputState> {
  IntakeInputBloc({
    required SaveIntakeHistoryUsecase saveIntakeHistoryUsecase,
  })  : _saveIntakeHistoryUsecase = saveIntakeHistoryUsecase,
        super(const IntakeInputInitial()) {
    on<IntakeInputSave>(saveIntakeHistory, transformer: droppable());
  }

  final SaveIntakeHistoryUsecase _saveIntakeHistoryUsecase;

  Future<void> saveIntakeHistory(IntakeInputSave event, Emitter<IntakeInputState> emit) async {
    emit(const IntakeInputSaveInProgress());

    final result = await _saveIntakeHistoryUsecase(
      hashId: event.hashId,
      recordTime: event.recordTime,
      beverageType: event.beverageType,
      recordVolume: event.recordVolume,
    );

    result.fold(
      (error) => emit(IntakeInputSaveFailure(error: error)),
      (_) => emit(const IntakeInputSaveSuccess()),
    );
  }
}
