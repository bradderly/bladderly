part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState({
    this.userModel,
  });

  final UserModel? userModel;

  UserModel get userModelOrThrowException => userModel ?? (throw Exception('UserModel is null'));

  @override
  List<Object?> get props => [
        userModel,
      ];
}

final class UserInitial extends UserState {
  const UserInitial() : super(userModel: null);
}

final class UserLoadSuccess extends UserState {
  const UserLoadSuccess({required UserModel super.userModel});
}

final class UserLoadFailure extends UserState {
  const UserLoadFailure({
    required super.userModel,
    required this.exception,
  });

  final Exception exception;

  @override
  List<Object?> get props => [
        ...super.props,
        exception,
      ];
}
