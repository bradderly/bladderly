part of 'main_history_bloc.dart';

sealed class MainHistoryEvent extends Equatable {
  const MainHistoryEvent();

  @override
  List<Object> get props => [];
}

/// Pending Status History Upload
class MainHistoryUploadPendingHistories extends MainHistoryEvent {
  const MainHistoryUploadPendingHistories({
    required this.userId,
  });

  final String userId;

  @override
  List<Object> get props => [
        userId,
      ];
}

/// Get Processing History Results
class MainHistoryGetHistoryResults extends MainHistoryEvent {
  const MainHistoryGetHistoryResults({
    required this.userId,
  });

  final String userId;

  @override
  List<Object> get props => [
        userId,
      ];
}
