part of 'main_histories_bloc.dart';

sealed class MainHistoriesEvent extends Equatable {
  const MainHistoriesEvent();

  @override
  List<Object> get props => [];
}

class MainHistoriesSyncronize extends MainHistoriesEvent {
  const MainHistoriesSyncronize({
    required this.userId,
  });

  final String userId;

  @override
  List<Object> get props => [
        userId,
      ];
}
