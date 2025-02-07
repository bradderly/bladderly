part of 'manual_input_voiding_bloc.dart';

sealed class ManualInputVoidingState extends Equatable {
  const ManualInputVoidingState();

  @override
  List<Object> get props => [];
}

final class ManualInputVoidingInitial extends ManualInputVoidingState {}

final class ManualInputVoidingSaveInProgress extends ManualInputVoidingState {}

final class ManualInputVoidingSaveSuccess extends ManualInputVoidingState {}

final class ManualInputVoidingSaveFailure extends ManualInputVoidingState {
  const ManualInputVoidingSaveFailure({
    required this.error,
  });

  final Exception error;

  @override
  List<Object> get props => [
        error,
      ];
}
