import 'package:bradderly/domain/model/history.dart';
import 'package:bradderly/domain/model/leakage_volume.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'manual_input_leakage_form_state.dart';

class ManualInputLeakageFormCubit extends Cubit<ManualInputLeakageFormState> {
  ManualInputLeakageFormCubit({
    required DateTime recordTime,
    History? history,
  }) : super(
          history == null
              ? ManualInputLeakageFormState(recordTime: recordTime)
              : ManualInputLeakageFormState.fromHistory(history: history),
        );

  void setRecordTime(DateTime recordTime) {
    emit(state.copyWith(recordTime: recordTime));
  }

  void setLeakageVolume(LeakageVolume? leakageVolume) {
    emit(state.copyWith(leakageVolume: leakageVolume));
  }

  void setMemo(String memo) {
    emit(state.copyWith(memo: memo));
  }
}
