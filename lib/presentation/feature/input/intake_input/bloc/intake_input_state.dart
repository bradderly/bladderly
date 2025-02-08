part of 'intake_input_bloc.dart';

sealed class IntakeInputState extends Equatable {
  const IntakeInputState();

  @override
  List<Object> get props => [];
}

final class IntakeInputInitial extends IntakeInputState {
  const IntakeInputInitial();
}

final class IntakeInputSaveInProgress extends IntakeInputState {
  const IntakeInputSaveInProgress();
}

final class IntakeInputSaveSuccess extends IntakeInputState {
  const IntakeInputSaveSuccess();
}

final class IntakeInputSaveFailure extends IntakeInputState {
  const IntakeInputSaveFailure({
    required this.error,
  });

  final Exception error;

  @override
  List<Object> get props => [
        error,
      ];
}
