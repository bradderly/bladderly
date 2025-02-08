part of 'intake_input_bloc.dart';

sealed class IntakeInputEvent extends Equatable {
  const IntakeInputEvent();

  @override
  List<Object> get props => [];
}

final class IntakeInputSave extends IntakeInputEvent {
  const IntakeInputSave({
    required this.hashId,
    required this.recordTime,
    required this.beverageType,
    required this.recordVolume,
  });

  final String hashId;
  final DateTime recordTime;
  final String beverageType;
  final int recordVolume;

  @override
  List<Object> get props => [
        hashId,
        recordTime,
        beverageType,
        recordVolume,
      ];
}
