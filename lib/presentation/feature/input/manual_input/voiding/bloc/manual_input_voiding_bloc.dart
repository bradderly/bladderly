// Package imports:
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:bladderly/domain/model/leakage_volume.dart';
import 'package:bladderly/domain/usecase/save_voiding_history_usecase.dart';

part 'manual_input_voiding_event.dart';
part 'manual_input_voiding_state.dart';

class ManualInputVoidingBloc extends Bloc<ManualInputVoidingEvent, ManualInputVoidingState> {
  ManualInputVoidingBloc({
    required SaveVoidingHistoryUsecase saveVoidingHistoryUsecase,
  })  : _saveVoidingHistoryUsecase = saveVoidingHistoryUsecase,
        super(ManualInputVoidingInitial()) {
    on<ManualInputVoidingSave>(_onSave, transformer: droppable());
  }

  final SaveVoidingHistoryUsecase _saveVoidingHistoryUsecase;

  Future<void> _onSave(ManualInputVoidingSave event, Emitter<ManualInputVoidingState> emit) async {
    emit(ManualInputVoidingSaveInProgress());

    final result = await _saveVoidingHistoryUsecase(
      userId: event.userId,
      id: event.id,
      recordTime: event.recordTime,
      recordVolume: event.recordVolume,
      recordUrgency: event.recordUrgency,
      isNocutria: event.isNocutria,
      isLeakage: event.isLeakage,
      leakageVolume: event.leakageVolume,
      memo: event.memo,
    );

    result.fold(
      (exception) => emit(ManualInputVoidingSaveFailure(error: exception)),
      (success) => emit(ManualInputVoidingSaveSuccess()),
    );
  }
}
