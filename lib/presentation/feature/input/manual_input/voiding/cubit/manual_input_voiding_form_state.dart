part of 'manual_input_voiding_form_cubit.dart';

class ManualInputVoidingFormState extends Equatable {
  const ManualInputVoidingFormState({
    required this.recordTime,
    required this.unit,
    this.recordAmount = '',
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
  })  : recordAmount = history == null ? '' : '${unit.parse(history.recordVolume).floor()}',
        recordUrgency = history?.recordUrgency,
        isNocutria = history?.isNocutria,
        isLeakage = history?.isLeakage,
        leakageVolume = history?.leakageVolume,
        memo = history?.memo ?? '';

  final DateTime recordTime;
  final String recordAmount;
  final Unit unit;
  final int? recordUrgency;
  final bool? isNocutria;
  final bool? isLeakage;
  final LeakageVolume? leakageVolume;
  final String memo;

  bool get isValid {
    if (int.tryParse(recordAmount) == null) return false;

    if (recordUrgency == null) return false;

    if (isNocutria == null) return false;

    if (isLeakage == null) return false;

    return true;
  }

  ManualInputVoidingFormState copyWith({
    DateTime? recordTime,
    String? recordAmount,
    Unit? unit,
    int? recordUrgency,
    bool? isNocutria,
    bool? isLeakage,
    LeakageVolume? leakageVolume,
    String? memo,
  }) {
    return ManualInputVoidingFormState(
      recordTime: recordTime ?? this.recordTime,
      recordAmount: recordAmount ?? this.recordAmount,
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
        recordAmount,
        unit,
        recordUrgency,
        isNocutria,
        isLeakage,
        leakageVolume,
        memo,
      ];
}
