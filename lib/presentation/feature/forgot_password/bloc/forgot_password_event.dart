part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class ForgotPasswordSendVerificationCode extends ForgotPasswordEvent {
  const ForgotPasswordSendVerificationCode({
    required this.email,
  });

  final String email;

  @override
  List<Object> get props => [
        email,
      ];
}

class ForgotPasswordChangePassword extends ForgotPasswordEvent {
  const ForgotPasswordChangePassword({
    required this.email,
    required this.verificationCode,
    required this.password,
  });

  final String email;
  final String verificationCode;
  final String password;

  @override
  List<Object> get props => [
        email,
        verificationCode,
        password,
      ];
}
