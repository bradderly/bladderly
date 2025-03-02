// Package imports:
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:bladderly/domain/usecase/change_password_usecase.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc({
    required ChangePasswordUsecase chagnePasswordUsecase,
  })  : _chagnePasswordUsecase = chagnePasswordUsecase,
        super(const MenuInitial()) {
    on<MenuEvent>(
      (event, emit) => switch (event) {
        ChangePassword() => _onChangePassord(event, emit),
      },
      transformer: droppable(),
    );
  }

  final ChangePasswordUsecase _chagnePasswordUsecase;

  Future<void> _onChangePassord(ChangePassword event, Emitter<MenuState> emit) async {
    emit(const MenuInProgress());

    final result = await _chagnePasswordUsecase(
      email: event.email,
      newPw: event.newPw,
      oldPw: event.oldPw,
    );

    result.fold(
      (exception) => emit(ChangePasswordFailure(exception: exception)),
      (success) => emit(const ChangePasswordSuccess()),
    );
  }
}
