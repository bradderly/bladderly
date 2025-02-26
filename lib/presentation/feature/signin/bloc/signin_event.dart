part of 'signin_bloc.dart';

sealed class SigninEvent extends Equatable {
  const SigninEvent();

  @override
  List<Object> get props => [];
}

class SigninEmail extends SigninEvent {
  const SigninEmail({
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

class SigninSocial extends SigninEvent {
  const SigninSocial({
    required this.socialMethod,
  });

  final SigninSocialMethodModel socialMethod;

  @override
  List<Object> get props => [
        socialMethod,
      ];
}
