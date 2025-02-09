part of 'manual_input_voiding_bloc.dart';

sealed class ManualInputVoidingEvent extends Equatable {
  const ManualInputVoidingEvent();

  @override
  List<Object?> get props => [];
}

final class ManualInputVoidingSave extends ManualInputVoidingEvent {
  const ManualInputVoidingSave({
    required this.id,
    required this.hashId,
    required this.recordTime,
    required this.recordVolume,
    required this.recordUrgency,
    required this.isNocutria,
    required this.isLeakage,
    required this.leakageVolume,
    required this.memo,
  });

  final int? id;
  final String hashId;
  final DateTime recordTime;
  final int recordVolume;
  final int recordUrgency;
  final bool isNocutria;
  final bool isLeakage;
  final LeakageVolume? leakageVolume;
  final String memo;

  @override
  List<Object?> get props => [
        id,
        hashId,
        recordTime,
        recordVolume,
        recordUrgency,
        isNocutria,
        isLeakage,
        leakageVolume,
        memo,
      ];
}
