part of 'intake_input_bloc.dart';

sealed class IntakeInputEvent extends Equatable {
  const IntakeInputEvent();

  @override
  List<Object?> get props => [];
}

final class IntakeInputSave extends IntakeInputEvent {
  const IntakeInputSave({
    required this.id,
    required this.hashId,
    required this.recordTime,
    required this.beverageType,
    required this.recordVolume,
    required this.memo,
  });

  final int? id;
  final String hashId;
  final DateTime recordTime;
  final String beverageType;
  final int recordVolume;
  final String memo;

  @override
  List<Object?> get props => [
        id,
        hashId,
        recordTime,
        beverageType,
        recordVolume,
        memo,
      ];
}
