part of 'manual_input_leakage_bloc.dart';

sealed class ManualInputLeakageState extends Equatable {
  const ManualInputLeakageState();

  @override
  List<Object> get props => [];
}

final class ManualInputLeakageInitial extends ManualInputLeakageState {}

final class ManualInputLeakageSaveInProgress extends ManualInputLeakageState {}

final class ManualInputLeakageSaveSuccess extends ManualInputLeakageState {}

final class ManualInputLeakageSaveFailure extends ManualInputLeakageState {
  const ManualInputLeakageSaveFailure({
    required this.error,
  });

  final Exception error;

  @override
  List<Object> get props => [
        error,
      ];
}
