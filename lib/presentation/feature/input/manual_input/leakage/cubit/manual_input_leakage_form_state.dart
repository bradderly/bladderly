part of 'manual_input_leakage_form_cubit.dart';

class ManualInputLeakageFormState extends Equatable {
  const ManualInputLeakageFormState({
    required this.recordTime,
    this.memo = '',
    this.id,
    this.leakageVolume,
  });

  factory ManualInputLeakageFormState.fromHistory({
    required History history,
  }) {
    if (history is! LeakageHistory) {
      return ManualInputLeakageFormState(
        id: history.id,
        recordTime: history.recordTime,
      );
    }

    return ManualInputLeakageFormState(
      id: history.id,
      recordTime: history.recordTime,
      leakageVolume: history.leakageVolume,
      memo: history.memo ?? '',
    );
  }

  final int? id;
  final LeakageVolume? leakageVolume;
  final DateTime recordTime;
  final String memo;

  ManualInputLeakageFormState copyWith({
    DateTime? recordTime,
    LeakageVolume? leakageVolume,
    String? memo,
  }) {
    return ManualInputLeakageFormState(
      id: id,
      recordTime: recordTime ?? this.recordTime,
      leakageVolume: leakageVolume ?? this.leakageVolume,
      memo: memo ?? this.memo,
    );
  }

  bool get isValid => leakageVolume != null;

  @override
  List<Object?> get props => [
        id,
        recordTime,
        leakageVolume,
        memo,
      ];
}
