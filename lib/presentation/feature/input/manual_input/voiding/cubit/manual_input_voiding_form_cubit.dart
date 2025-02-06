import 'package:bradderly/domain/model/history.dart';
import 'package:bradderly/domain/model/leakage_volume.dart';
import 'package:bradderly/domain/model/unit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'manual_input_voiding_form_state.dart';

class ManualInputVoidingFormCubit extends Cubit<ManualInputVoidingFormState> {
  ManualInputVoidingFormCubit({
    required Unit unit,
    required DateTime recordTime,
    required VoidingHistory? history,
  }) : super(ManualInputVoidingFormState.fromHistory(recordTime: recordTime, unit: unit, history: history));

  void setRecordTime(DateTime recordTime) {
    emit(state.copyWith(recordTime: recordTime));
  }

  void setRecordAmount(String recordAmount) {
    emit(state.copyWith(recordAmount: recordAmount));
  }

  void setUnit(Unit unit) {
    emit(state.copyWith(unit: unit));
  }

  void setLevel(int level) {
    emit(state.copyWith(recordUrgency: level));
  }

  void setIsNocutria(bool isNocutria) {
    emit(state.copyWith(isNocutria: isNocutria));
  }

  void setIsLeakage(bool isLeakage) {
    emit(state.copyWith(isLeakage: isLeakage));
  }

  void setLeakageVolume(LeakageVolume leakageVolume) {
    emit(state.copyWith(leakageVolume: leakageVolume));
  }

  void setMemo(String memo) {
    emit(state.copyWith(memo: memo));
  }
}
