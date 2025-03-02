part of 'sign_up_regular_bloc.dart';

sealed class SignUpRegularEvent extends Equatable {
  const SignUpRegularEvent();

  @override
  List<Object> get props => [];
}

class SignUpRegularSubmit extends SignUpRegularEvent {
  const SignUpRegularSubmit({
    required this.userId,
    required this.email,
    required this.password,
    required this.userName,
    required this.disease,
  });

  final String userId;
  final String email;
  final String password;
  final String userName;
  final String disease;

  @override
  List<Object> get props => [
        userId,
        email,
        password,
        userName,
        disease,
      ];
}
