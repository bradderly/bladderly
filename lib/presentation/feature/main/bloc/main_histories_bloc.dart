import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_histories_event.dart';
part 'main_histories_state.dart';

class MainHistoriesBloc extends Bloc<MainHistoriesEvent, MainHistoriesState> {
  MainHistoriesBloc() : super(MainHistoriesInitial()) {
    on<MainHistoriesEvent>((event, emit) {}, transformer: droppable());
  }
}
