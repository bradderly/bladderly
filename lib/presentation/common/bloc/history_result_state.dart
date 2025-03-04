part of 'history_result_bloc.dart';

sealed class HistoryResultState extends Equatable {
  const HistoryResultState();

  @override
  List<Object> get props => [];
}

final class HistoryResultInitial extends HistoryResultState {}

final class HistoryResultGetInProgress extends HistoryResultState {
  const HistoryResultGetInProgress();
}

final class HistoryResultGetSuccess extends HistoryResultState {
  const HistoryResultGetSuccess();
}

final class HistoryResultGetFailure extends HistoryResultState {
  const HistoryResultGetFailure({
    required this.exception,
  });

  final Exception exception;

  @override
  List<Object> get props => [
        ...super.props,
        exception,
      ];
}

final class HistoryResultRefreshInProgress extends HistoryResultState {
  const HistoryResultRefreshInProgress();
}

final class HistoryResultRefreshSuccess extends HistoryResultState {
  const HistoryResultRefreshSuccess();
}

final class HistoryResultRefreshFailure extends HistoryResultState {
  const HistoryResultRefreshFailure({
    required this.exception,
  });

  final Exception exception;

  @override
  List<Object> get props => [
        ...super.props,
        exception,
      ];
}
