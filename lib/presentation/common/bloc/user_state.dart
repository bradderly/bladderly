part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState({
    required this.userModel,
  });

  final UserModel userModel;

  @override
  List<Object> get props => [
        userModel,
      ];
}

final class UserInitial extends UserState {
  const UserInitial() : super(userModel: const UserModel.none());
}

final class UserLoadInProgress extends UserState {
  const UserLoadInProgress({required super.userModel});
}

final class UserLoadSuccess extends UserState {
  const UserLoadSuccess({required super.userModel});
}

final class UserLoadFailure extends UserState {
  const UserLoadFailure({required super.userModel});
}
