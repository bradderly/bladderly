part of 'intake_input_form_cubit.dart';

class IntakeInputFormState extends Equatable {
  const IntakeInputFormState({
    required this.unit,
    required this.recordTime,
    this.id,
    this.beverageModel,
    this.recordVolumeModel,
    this.memo = '',
  });

  factory IntakeInputFormState.fromBeverageTypeModel({
    required Unit unit,
    required DateTime recordTime,
    BeverageTypeModel? beverageTypeModel,
  }) {
    return IntakeInputFormState(
      unit: unit,
      recordTime: recordTime,
      beverageModel: beverageTypeModel == null ? null : IntakeInputBeverageModel.onlyType(beverageTypeModel),
    );
  }

  factory IntakeInputFormState.fromHistory({
    required Unit unit,
    required IntakeHistory intakeHistory,
  }) {
    final beverageTypeModel = BeverageTypeModel.of(intakeHistory.beverageType);
    return IntakeInputFormState(
      id: intakeHistory.id,
      unit: unit,
      recordTime: intakeHistory.recordTime,
      beverageModel: IntakeInputBeverageModel(
        typeModel: beverageTypeModel,
        typeValue: beverageTypeModel == BeverageTypeModel.others ? intakeHistory.beverageType : '',
      ),
      recordVolumeModel: IntakeInputRecordVolumeModel.fromVolume(intakeHistory.recordVolume),
      memo: intakeHistory.memo ?? '',
    );
  }

  final int? id;
  final Unit unit;
  final DateTime recordTime;
  final IntakeInputBeverageModel? beverageModel;
  final IntakeInputRecordVolumeModel? recordVolumeModel;
  final String memo;

  bool get isValid {
    if (beverageModel?.isValid != true) {
      return false;
    }

    if (recordVolumeModel?.isValid != true) {
      return false;
    }

    return true;
  }

  IntakeInputFormState copyWith({
    Unit? unit,
    DateTime? recordTime,
    IntakeInputBeverageModel? beverageModel,
    IntakeInputRecordVolumeModel? recordVolumeModel,
    String? memo,
  }) {
    return IntakeInputFormState(
      id: id,
      unit: unit ?? this.unit,
      recordTime: recordTime ?? this.recordTime,
      beverageModel: beverageModel ?? this.beverageModel,
      recordVolumeModel: recordVolumeModel ?? this.recordVolumeModel,
      memo: memo ?? this.memo,
    );
  }

  @override
  List<Object?> get props => [
        id,
        unit,
        recordTime,
        beverageModel,
        recordVolumeModel,
        memo,
      ];
}
