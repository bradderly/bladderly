part of 'manual_input_voiding_form_cubit.dart';

class ManualInputVoidingFormState extends Equatable {
  const ManualInputVoidingFormState({
    required this.recordTime,
    required this.unit,
    this.id,
    this.recordVolume = '',
    this.recordUrgency,
    this.isNocutria,
    this.isLeakage,
    this.leakageVolume,
    this.memo = '',
  });

  factory ManualInputVoidingFormState.fromHistory({
    required History history,
    required Unit unit,
  }) {
    if (history is! VoidingHistory) {
      return ManualInputVoidingFormState(
        id: history.id,
        recordTime: history.recordTime,
        unit: unit,
      );
    }

    return ManualInputVoidingFormState(
      id: history.id,
      recordTime: history.recordTime,
      recordVolume: '${unit.parseFromMl(history.recordVolume)}',
      unit: unit,
      recordUrgency: history.recordUrgency,
      isNocutria: history.isNocutria,
      isLeakage: history.isLeakage,
      leakageVolume: history.leakageVolume,
      memo: history.memo ?? '',
    );
  }

  final int? id;
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
      id: id,
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
        id,
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
