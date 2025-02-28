part of 'detailed_list_histories_bloc.dart';

sealed class DetailedListHistoriesEvent extends Equatable {
  const DetailedListHistoriesEvent();

  @override
  List<Object> get props => [];
}

class DetailedListHistoriesSubscribe extends DetailedListHistoriesEvent {
  const DetailedListHistoriesSubscribe({
    required this.userId,
    required this.dateTime,
  });

  final String userId;
  final DateTime dateTime;

  @override
  List<Object> get props => [
        userId,
        dateTime,
      ];
}

class DetailedListHistoriesDelete extends DetailedListHistoriesEvent {
  const DetailedListHistoriesDelete({
    required this.id,
  });

  final int id;

  @override
  List<Object> get props => [
        id,
      ];
}
