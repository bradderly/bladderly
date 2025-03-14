part of 'change_password_bloc.dart';

sealed class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object> get props => [];
}

class ChangePassword extends ChangePasswordEvent {
  const ChangePassword({
    required this.email,
    required this.newPw,
    required this.oldPw,
  });

  final String email;
  final String newPw;
  final String oldPw;

  @override
  List<Object> get props => [
        email,
        newPw,
        oldPw,
      ];
}
