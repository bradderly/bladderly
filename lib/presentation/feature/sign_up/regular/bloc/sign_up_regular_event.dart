part of 'sign_up_regular_bloc.dart';

sealed class SignUpRegularEvent extends Equatable {
  const SignUpRegularEvent();

  @override
  List<Object> get props => [];
}

class SignUpRegularCheckDuplicateEmail extends SignUpRegularEvent {
  const SignUpRegularCheckDuplicateEmail({
    required this.email,
  });

  final String email;

  @override
  List<Object> get props => [
        email,
      ];
}

class SignUpRegularSubmit extends SignUpRegularEvent {
  const SignUpRegularSubmit({
    required this.signUpMethod,
    required this.userId,
    required this.email,
    required this.password,
    required this.userName,
    required this.disease,
  });

  final SignUpMethod signUpMethod;
  final String userId;
  final String email;
  final String password;
  final String userName;
  final String disease;

  @override
  List<Object> get props => [
        signUpMethod,
        userId,
        email,
        password,
        userName,
        disease,
      ];
}
