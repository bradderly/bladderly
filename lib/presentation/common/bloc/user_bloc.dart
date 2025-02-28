import 'package:bladderly/domain/model/user.dart';
import 'package:bladderly/domain/usecase/get_user_stream_usecase.dart';
import 'package:bladderly/domain/usecase/get_user_usecase.dart';
import 'package:bladderly/presentation/common/model/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends HydratedBloc<UserEvent, UserState> {
  UserBloc({
    required GetUserUsecase getUserUsecase,
    required GetUserStreamUsecase getUserStreamUsecase,
  })  : _getUserUsecase = getUserUsecase,
        _getUserStreamUsecase = getUserStreamUsecase,
        super(const UserInitial()) {
    on<UserLoad>(_onLoad);
  }

  final GetUserUsecase _getUserUsecase;
  final GetUserStreamUsecase _getUserStreamUsecase;

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
}
