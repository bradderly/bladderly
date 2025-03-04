part of 'main_history_bloc.dart';

sealed class MainHistoryState extends Equatable {
  const MainHistoryState();

  @override
  List<Object> get props => [];
}

final class MainPendingHistoryInitial extends MainHistoryState {
  const MainPendingHistoryInitial();
}

final class MainHistoryUploadPendingHistoriesInProgress extends MainHistoryState {
  const MainHistoryUploadPendingHistoriesInProgress();
}

final class MainHistoryUploadPendingHistoriesSuccess extends MainHistoryState {
  const MainHistoryUploadPendingHistoriesSuccess();
}

final class MainHistoryUploadPendingHistoriesFailure extends MainHistoryState {
  const MainHistoryUploadPendingHistoriesFailure({
    required this.exception,
  });

  final Exception exception;

  @override
  List<Object> get props => [
        exception,
      ];
}

final class MainHistoryGetHistoryResultsInProgress extends MainHistoryState {
  const MainHistoryGetHistoryResultsInProgress();
}

final class MainHistoryGetHistoryResultsSuccess extends MainHistoryState {
  const MainHistoryGetHistoryResultsSuccess();
}

final class MainHistoryGetHistoryResultsFailure extends MainHistoryState {
  const MainHistoryGetHistoryResultsFailure({
    required this.exception,
  });

  final Exception exception;

  @override
  List<Object> get props => [
        exception,
      ];
}
