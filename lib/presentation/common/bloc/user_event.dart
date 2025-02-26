part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserChange extends UserEvent {
  const UserChange({
    required this.userModel,
  });

  final UserModel userModel;
}
