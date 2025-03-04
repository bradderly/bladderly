part of 'history_result_bloc.dart';

sealed class HistoryResultEvent extends Equatable {
  const HistoryResultEvent();

  @override
  List<Object> get props => [];
}

class HistoryResultGet extends HistoryResultEvent {
  const HistoryResultGet({
    required this.userId,
    required this.historyId,
  });

  final String userId;
  final int historyId;

  @override
  List<Object> get props => [
        userId,
        historyId,
      ];
}

class HistoryResultRefresh extends HistoryResultEvent {
  const HistoryResultRefresh({
    required this.userId,
    required this.historyId,
  });

  final String userId;
  final int historyId;

  @override
  List<Object> get props => [
        userId,
        historyId,
      ];
}
