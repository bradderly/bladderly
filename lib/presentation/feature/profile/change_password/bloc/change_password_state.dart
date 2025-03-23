part of 'change_password_bloc.dart';

sealed class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object> get props => [];
}

final class ChangePasswordInitial extends ChangePasswordState {
  const ChangePasswordInitial();
}

final class ChangePasswordInProgress extends ChangePasswordState {
  const ChangePasswordInProgress();
}

final class ChangePasswordSuccess extends ChangePasswordState {
  const ChangePasswordSuccess();
}

final class ChangePasswordFailure extends ChangePasswordState {
  const ChangePasswordFailure({
    required this.exception,
  });

  final Exception exception;

  @override
  List<Object> get props => [
        ...super.props,
        exception,
      ];
}
