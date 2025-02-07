part of 'manual_input_voiding_form_cubit.dart';

class ManualInputVoidingFormState extends Equatable {
  const ManualInputVoidingFormState({
    required this.recordTime,
    required this.unit,
    this.recordVolume = '',
    this.recordUrgency,
    this.isNocutria,
    this.isLeakage,
    this.leakageVolume,
    this.memo = '',
  });

  ManualInputVoidingFormState.fromHistory({
    required this.recordTime,
    required this.unit,
    VoidingHistory? history,
  })  : recordVolume = history == null ? '' : '${unit.parseFromMl(history.recordVolume)}',
        recordUrgency = history?.recordUrgency,
        isNocutria = history?.isNocutria,
        isLeakage = history?.isLeakage,
        leakageVolume = history?.leakageVolume,
        memo = history?.memo ?? '';

  final DateTime recordTime;
  final String recordVolume;
  final Unit unit;
  final int? recordUrgency;
  final bool? isNocutria;
  final bool? isLeakage;
  final LeakageVolume? leakageVolume;
  final String memo;

  bool get isValid {
    if (int.tryParse(recordVolume) == null) return false;

    if (recordUrgency == null) return false;

    if (isNocutria == null) return false;

    if (isLeakage == null) return false;

    if (isLeakage == true && leakageVolume == null) return false;

    return true;
  }

  ManualInputVoidingFormState copyWith({
    DateTime? recordTime,
    String? recordVolume,
    Unit? unit,
    int? recordUrgency,
    bool? isNocutria,
    bool? isLeakage,
    LeakageVolume? leakageVolume,
    String? memo,
  }) {
    return ManualInputVoidingFormState(
      recordTime: recordTime ?? this.recordTime,
      recordVolume: recordVolume ?? this.recordVolume,
      unit: unit ?? this.unit,
      recordUrgency: recordUrgency ?? this.recordUrgency,
      isNocutria: isNocutria ?? this.isNocutria,
      isLeakage: isLeakage ?? this.isLeakage,
      leakageVolume: leakageVolume ?? this.leakageVolume,
      memo: memo ?? this.memo,
    );
  }

  @override
  List<Object?> get props => [
        recordTime,
        recordVolume,
        unit,
        recordUrgency,
        isNocutria,
        isLeakage,
        leakageVolume,
        memo,
      ];
}
