part of 'manual_input_leakage_form_cubit.dart';

class ManualInputLeakageFormState extends Equatable {
  const ManualInputLeakageFormState({
    required this.recordTime,
    required this.leakageVolume,
    required this.memo,
  });

  ManualInputLeakageFormState.fromHistory({
    required this.recordTime,
    LeakageHistory? history,
  })  : leakageVolume = history?.leakageVolume,
        memo = history?.memo ?? '';

  final LeakageVolume? leakageVolume;
  final DateTime recordTime;
  final String memo;

  ManualInputLeakageFormState copyWith({
    DateTime? recordTime,
    LeakageVolume? leakageVolume,
    String? memo,
  }) {
    return ManualInputLeakageFormState(
      recordTime: recordTime ?? this.recordTime,
      leakageVolume: leakageVolume ?? this.leakageVolume,
      memo: memo ?? this.memo,
    );
  }

  bool get isValid => leakageVolume != null;

  @override
  List<Object?> get props => [
        recordTime,
        leakageVolume,
        memo,
      ];
}
