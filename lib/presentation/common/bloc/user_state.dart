part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState({
    required this.userModel,
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

final class UserChangeSuccess extends UserState {
  const UserChangeSuccess({required UserModel super.userModel});
}
