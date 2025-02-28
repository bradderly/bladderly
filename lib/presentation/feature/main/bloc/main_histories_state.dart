part of 'main_histories_bloc.dart';

sealed class MainHistoriesState extends Equatable {
  const MainHistoriesState();
  
  @override
  List<Object> get props => [];
}

final class MainHistoriesInitial extends MainHistoriesState {}
