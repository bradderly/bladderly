part of 'signin_bloc.dart';

sealed class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

final class SignInInitial extends SignInState {
  const SignInInitial();
}

final class SignInInProgress extends SignInState {
  const SignInInProgress();
}

final class SignInEmailSuccess extends SignInState {
  const SignInEmailSuccess();
}

final class SignInEmailFailure extends SignInState {
  const SignInEmailFailure({
    required this.exception,
  });

  final Exception exception;

  @override
  List<Object> get props => [
        ...super.props,
        exception,
      ];
}

final class SignInSocialSuccess extends SignInState {
  const SignInSocialSuccess({
    required this.signUpMethod,
    required this.email,
  });

  final SignUpMethod signUpMethod;
  final String email;

  @override
  List<Object> get props => [
        ...super.props,
        signUpMethod,
      ];
}

final class SignInSocialFailure extends SignInState {
  const SignInSocialFailure({
    required this.signUpMethod,
    required this.exception,
  });

  final SignUpMethod signUpMethod;
  final Exception exception;

  @override
  List<Object> get props => [
        ...super.props,
        signUpMethod,
        exception,
      ];
}
