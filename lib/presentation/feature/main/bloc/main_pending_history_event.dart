part of 'main_pending_history_bloc.dart';

sealed class MainPendingHistoryEvent extends Equatable {
  const MainPendingHistoryEvent();

  @override
  List<Object> get props => [];
}

class MainPendingHistoryUpload extends MainPendingHistoryEvent {
  const MainPendingHistoryUpload({
    required this.userId,
  });

  final String userId;

  @override
  List<Object> get props => [
        userId,
      ];
}
