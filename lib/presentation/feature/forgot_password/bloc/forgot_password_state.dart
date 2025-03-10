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

final class ForgotPasswordChangePasswordInProgress extends ForgotPasswordState {
  const ForgotPasswordChangePasswordInProgress();
}

final class ForgotPasswordChangePasswordSuccess extends ForgotPasswordState {
  const ForgotPasswordChangePasswordSuccess();
}

final class ForgotPasswordChangePasswordFailure extends ForgotPasswordState {
  const ForgotPasswordChangePasswordFailure({
    required this.exception,
  });

  final Exception exception;

  @override
  List<Object> get props => [
        ...super.props,
        exception,
      ];
}
