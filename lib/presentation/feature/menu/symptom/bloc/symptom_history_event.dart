part of 'symptom_history_bloc.dart';

sealed class SymptomHistoryEvent extends Equatable {
  const SymptomHistoryEvent();

  @override
  List<Object> get props => [];
}

class SymptomHistory extends SymptomHistoryEvent {
  const SymptomHistory({
    required this.userId,
  });

  final String userId;

  @override
  List<Object> get props => [
        userId,
      ];
}
