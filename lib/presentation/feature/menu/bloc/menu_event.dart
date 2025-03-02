part of 'menu_bloc.dart';

sealed class MenuEvent extends Equatable {
  const MenuEvent();

  @override
  List<Object> get props => [];
}

class ChangePassword extends MenuEvent {
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
