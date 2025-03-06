part of 'symptom_history_bloc.dart';

sealed class SymptomHistoryState extends Equatable {
  const SymptomHistoryState();

  @override
  List<Object> get props => [];
}

final class SymptomHistoryInitial extends SymptomHistoryState {
  const SymptomHistoryInitial();
}

final class SymptomHistoryProgress extends SymptomHistoryState {
  const SymptomHistoryProgress();
}

final class SymptomHistorySuccess extends SymptomHistoryState {
  const SymptomHistorySuccess();
}

final class SymptomHistoryFailure extends SymptomHistoryState {
  const SymptomHistoryFailure({
    required this.exception,
  });

  final Exception exception;

  @override
  List<Object> get props => [
        ...super.props,
        exception,
      ];
}
