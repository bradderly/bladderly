part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  bool get showSendVerificationCodeForm {
    return switch (this) {
      ForgotPasswordInitial() => true,
      ForgotPasswordSendVerificationCodeInProgress() => true,
      ForgotPasswordSendVerificationCodeFailure() => true,
      _ => false,
    };
  }

  @override
  List<Object> get props => [];
}

final class ForgotPasswordInitial extends ForgotPasswordState {
  const ForgotPasswordInitial();
}

final class ForgotPasswordSendVerificationCodeInProgress extends ForgotPasswordState {
  const ForgotPasswordSendVerificationCodeInProgress();
}

final class ForgotPasswordSendVerificationCodeSuccess extends ForgotPasswordState {
  const ForgotPasswordSendVerificationCodeSuccess();
}

final class ForgotPasswordSendVerificationCodeFailure extends ForgotPasswordState {
  const ForgotPasswordSendVerificationCodeFailure({
    required this.exception,
  });

  final Exception exception;

  @override
  List<Object> get props => [
        ...super.props,
        exception,
      ];
}

final class ForgotPasswordResetPasswordInProgress extends ForgotPasswordState {
  const ForgotPasswordResetPasswordInProgress();
}

final class ForgotPasswordResetPasswordSuccess extends ForgotPasswordState {
  const ForgotPasswordResetPasswordSuccess();
}

final class ForgotPasswordResetPasswordFailure extends ForgotPasswordState {
  const ForgotPasswordResetPasswordFailure({
    required this.exception,
  });

  final Exception exception;

  @override
  List<Object> get props => [
        ...super.props,
        exception,
      ];
}
