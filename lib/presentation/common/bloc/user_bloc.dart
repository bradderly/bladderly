import 'package:bladderly/domain/model/user.dart';
import 'package:bladderly/domain/usecase/get_user_stream_usecase.dart';
import 'package:bladderly/domain/usecase/get_user_usecase.dart';
import 'package:bladderly/domain/usecase/sign_out_usecase.dart';
import 'package:bladderly/presentation/common/model/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends HydratedBloc<UserEvent, UserState> {
  UserBloc({
    required GetUserUsecase getUserUsecase,
    required GetUserStreamUsecase getUserStreamUsecase,
    required SignOutUsecase signOutUsecase,
  })  : _getUserUsecase = getUserUsecase,
        _getUserStreamUsecase = getUserStreamUsecase,
        _signOutUsecase = signOutUsecase,
        super(const UserInitial()) {
    on<UserLoad>(_onLoad);
    on<UserSignOut>(_onSignOut);
  }

  final GetUserUsecase _getUserUsecase;
  final GetUserStreamUsecase _getUserStreamUsecase;
  final SignOutUsecase _signOutUsecase;

  void _onLoad(UserLoad event, Emitter<UserState> emit) {
    return _getUserStreamUsecase().fold(
      (exception) => emit(UserLoadFailure(exception: exception, userModel: state._userModel)),
      (stream) => emit.forEach<User?>(
        stream,
        onData: (user) => user == null ? const UserInitial() : UserLoadSuccess(userModel: UserModel.fromDomain(user)),
        onError: (exception, stackTrace) => UserLoadFailure(
          exception: exception is Exception ? exception : Exception(exception.toString()),
          userModel: state._userModel,
        ),
      ),
    );
  }

  void _onSignOut(UserSignOut event, Emitter<UserState> emit) {
    return _signOutUsecase().fold(
      (exception) => state,
      (_) => emit(const UserInitial()),
    );
  }

  @override
  UserState? fromJson(Map<String, dynamic> json) {
    if (json['user_id'] case final String userId) {
      return _getUserUsecase(userId).fold(
        (exception) => null,
        (user) => user == null ? null : UserLoadSuccess(userModel: UserModel.fromDomain(user)),
      );
    }

    return null;
  }

  @override
  Map<String, dynamic>? toJson(UserState state) {
    return {
      'user_id': state._userModel?.id,
    };
  }

  // 이메일만 가져오는 메소드 추가
  String? getUserEmail(UserState state) {
    if (state is UserLoadSuccess && state._userModel != null) {
      //  return state._userModel.email;
      return null;
    }
    return null;
  }
}
