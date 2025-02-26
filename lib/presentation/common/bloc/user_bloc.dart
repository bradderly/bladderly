import 'package:bradderly/presentation/common/model/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserInitial()) {
    on<UserChange>(_onChange);
  }

  void _onChange(UserChange event, Emitter<UserState> emit) {
    emit(UserChangeSuccess(userModel: event.userModel));
  }
}
