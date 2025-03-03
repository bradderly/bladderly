import 'package:bladderly/domain/usecase/profile_usecase.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required ProfileUsecase chagnePasswordUsecase,
  })  : _chagneName = chagnePasswordUsecase,
        super(const ProfileInitial()) {
    on<ProfileEvent>(
      (event, emit) => switch (event) {
        Profile() => _onChangePassord(event, emit),
      },
      transformer: droppable(),
    );
  }

  final ProfileUsecase _chagneName;

  Future<void> _onChangePassord(Profile event, Emitter<ProfileState> emit) async {
    emit(const ProfileProgress());

    final result = await _chagneName(
      name: event.email,
    );

    result.fold(
      (exception) => emit(ProfileFailure(exception: exception)),
      (success) => emit(const ProfileSuccess()),
    );
  }
}
