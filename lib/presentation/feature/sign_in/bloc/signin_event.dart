part of 'signin_bloc.dart';

sealed class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class SignInEmail extends SignInEvent {
  const SignInEmail({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object> get props => [
        email,
        password,
      ];
}

class SignInSocial extends SignInEvent {
  const SignInSocial({
    required this.signUpMethod,
  });

  final SignUpMethod signUpMethod;

  @override
  List<Object> get props => [
        signUpMethod,
      ];
}
