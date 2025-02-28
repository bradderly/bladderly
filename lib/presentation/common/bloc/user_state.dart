part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState({
    required UserModel? userModel,
  }) : _userModel = userModel;

  final UserModel? _userModel;

  UserModel get userModelOrThrowException => _userModel ?? (throw Exception('UserModel is null'));

  @override
  List<Object?> get props => [
        _userModel,
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
