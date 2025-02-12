part of 'detailed_list_histories_bloc.dart';

sealed class DetailedListHistoriesState extends Equatable {
  const DetailedListHistoriesState({
    required this.groupedHistoriesModel,
  });

  final DetailedListGroupedHistoriesModel groupedHistoriesModel;

  @override
  List<Object> get props => [
        groupedHistoriesModel,
      ];
}

final class DetailedListHistoriesInitial extends DetailedListHistoriesState {
  const DetailedListHistoriesInitial() : super(groupedHistoriesModel: const DetailedListGroupedHistoriesModel.empty());
}

final class DetailedListHistoriesSubscribeSuccess extends DetailedListHistoriesState {
  const DetailedListHistoriesSubscribeSuccess({
    required super.groupedHistoriesModel,
  });
}

final class DetailedListHistoriesSubscribeFailure extends DetailedListHistoriesState {
  const DetailedListHistoriesSubscribeFailure({
    required super.groupedHistoriesModel,
    required this.exception,
  });

  final Exception exception;

  @override
  List<Object> get props => [
        ...super.props,
        exception,
      ];
}

final class DetailedListHistoriesLoadSuccess extends DetailedListHistoriesState {
  const DetailedListHistoriesLoadSuccess({
    required super.groupedHistoriesModel,
  });
}

final class DetailedListHistoriesLoadFailure extends DetailedListHistoriesState {
  const DetailedListHistoriesLoadFailure({
    required super.groupedHistoriesModel,
    required this.exception,
  });

  final Exception exception;

  @override
  List<Object> get props => [
        ...super.props,
        exception,
      ];
}

final class DetailedListHistoriesDeleteInProgress extends DetailedListHistoriesState {
  const DetailedListHistoriesDeleteInProgress({
    required super.groupedHistoriesModel,
  });
}

final class DetailedListHistoriesDeleteSuccess extends DetailedListHistoriesState {
  const DetailedListHistoriesDeleteSuccess({
    required super.groupedHistoriesModel,
  });
}

final class DetailedListHistoriesDeleteFailure extends DetailedListHistoriesState {
  const DetailedListHistoriesDeleteFailure({
    required super.groupedHistoriesModel,
    required this.exception,
  });

  final Exception exception;

  @override
  List<Object> get props => [
        ...super.props,
        exception,
      ];
}
