import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bradderly/domain/model/leakage_volume.dart';
import 'package:bradderly/domain/usecase/save_leakage_history_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'manual_input_leakage_event.dart';
part 'manual_input_leakage_state.dart';

class ManualInputLeakageBloc extends Bloc<ManualInputLeakageEvent, ManualInputLeakageState> {
  ManualInputLeakageBloc({
    required SaveLeakageHistoryUsecase saveLeakageHistoryUsecase,
  })  : _saveLeakageHistoryUsecase = saveLeakageHistoryUsecase,
        super(ManualInputLeakageInitial()) {
    on<ManualInputLeakageSave>(_onSave, transformer: droppable());
  }

  final SaveLeakageHistoryUsecase _saveLeakageHistoryUsecase;

  Future<void> _onSave(ManualInputLeakageSave event, Emitter<ManualInputLeakageState> emit) async {
    emit(ManualInputLeakageSaveInProgress());

    final result = await _saveLeakageHistoryUsecase(
      hashId: event.hashId,
      leakageVolume: event.leakageVolume,
      recordTime: event.recordTime,
      memo: event.memo,
    );

    result.fold(
      (error) => emit(ManualInputLeakageSaveFailure(error: error)),
      (_) => emit(ManualInputLeakageSaveSuccess()),
    );
  }
}
