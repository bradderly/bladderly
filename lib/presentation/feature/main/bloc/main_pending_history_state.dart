part of 'main_pending_history_bloc.dart';

sealed class MainPendingHistoryState extends Equatable {
  const MainPendingHistoryState();

  @override
  List<Object> get props => [];
}

final class MainPendingHistoryInitial extends MainPendingHistoryState {
  const MainPendingHistoryInitial();
}

final class MainPendingHistoryUploadInProgress extends MainPendingHistoryState {
  const MainPendingHistoryUploadInProgress();
}

final class MainPendingHistoryUploadSuccess extends MainPendingHistoryState {
  const MainPendingHistoryUploadSuccess();
}

final class MainPendingHistoryUploadFailure extends MainPendingHistoryState {
  const MainPendingHistoryUploadFailure({
    required this.exception,
  });

  final Exception exception;

  @override
  List<Object> get props => [
        exception,
      ];
}
