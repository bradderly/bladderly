part of 'manual_input_leakage_bloc.dart';

sealed class ManualInputLeakageEvent extends Equatable {
  const ManualInputLeakageEvent();

  @override
  List<Object?> get props => [];
}

final class ManualInputLeakageSave extends ManualInputLeakageEvent {
  const ManualInputLeakageSave({
    required this.id,
    required this.hashId,
    required this.leakageVolume,
    required this.recordTime,
    required this.memo,
  });

  final int? id;
  final String hashId;
  final LeakageVolume leakageVolume;
  final DateTime recordTime;
  final String memo;

  @override
  List<Object?> get props => [
        id,
        hashId,
        leakageVolume,
        recordTime,
        memo,
      ];
}
