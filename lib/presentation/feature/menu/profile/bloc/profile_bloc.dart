// Package imports:
// Project imports:
import 'package:bladderly/domain/usecase/change_user_name_usecase.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required ChangeUserNameUsecase changeUserNameUsecase,
  })  : _changeUserNameUsecase = changeUserNameUsecase,
        super(const ProfileInitial()) {
    on<ProfileChangeName>(_onChangeName, transformer: droppable());
  }

  final ChangeUserNameUsecase _changeUserNameUsecase;

  Future<void> _onChangeName(ProfileChangeName event, Emitter<ProfileState> emit) async {
    emit(const ProfileChangeNameInProgress());

    final result = await _changeUserNameUsecase(
      userId: event.userId,
      userName: event.userName,
    );

    result.fold(
      (exception) => emit(ProfileChangeNameFailure(exception: exception)),
      (_) => emit(const ProfileChangeNameSuccess()),
    );
  }
}
