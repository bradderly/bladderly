import 'package:bradderly/domain/model/history.dart';
import 'package:bradderly/domain/model/unit.dart';
import 'package:bradderly/presentation/common/model/beverage_type_model.dart';
import 'package:bradderly/presentation/feature/input/intake_input/model/intake_input_beverage_model.dart';
import 'package:bradderly/presentation/feature/input/intake_input/model/intake_input_drink_volume_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'intake_input_form_state.dart';

class IntakeInputFormCubit extends Cubit<IntakeInputFormState> {
  IntakeInputFormCubit({
    required Unit unit,
    required DateTime recordTime,
    required BeverageTypeModel? beverageTypeModel,
    required IntakeHistory? intakeHistory,
  }) : super(
          switch (intakeHistory) {
            final IntakeHistory intakeHistory => IntakeInputFormState.fromHistory(
                unit: unit,
                intakeHistory: intakeHistory,
              ),
            _ => beverageTypeModel == null
                ? IntakeInputFormState(unit: unit, recordTime: recordTime)
                : IntakeInputFormState.fromBeverageTypeModel(
                    unit: unit,
                    recordTime: recordTime,
                    beverageTypeModel: beverageTypeModel,
                  ),
          },
        );

  void setUnit(Unit unit) {
    emit(state.copyWith(unit: unit));
  }

  void setRecordTime(DateTime recordTime) {
    emit(state.copyWith(recordTime: recordTime));
  }

  void setBeverageModel(IntakeInputBeverageModel beverageModel) {
    emit(state.copyWith(beverageModel: beverageModel));
  }

  void setRecordVolumeModel(IntakeInputRecordVolumeModel recordVolumeModel) {
    emit(state.copyWith(recordVolumeModel: recordVolumeModel));
  }

  void setMemo(String memo) {
    emit(state.copyWith(memo: memo));
  }
}
