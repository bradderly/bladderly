part of 'signup_guest_bloc.dart';

sealed class SignUpGuestState extends Equatable {
  const SignUpGuestState();

  @override
  List<Object> get props => [];
}

final class SignupGuestInitial extends SignUpGuestState {
  const SignupGuestInitial();
}

final class SignupGuestSubmitInProgress extends SignUpGuestState {
  const SignupGuestSubmitInProgress();
}

final class SignupGuestSubmitSuccess extends SignUpGuestState {
  const SignupGuestSubmitSuccess();
}

final class SignupGuestSubmitFailure extends SignUpGuestState {
  const SignupGuestSubmitFailure({required this.exception});

  final Exception exception;

  @override
  List<Object> get props => [
        ...super.props,
        exception,
      ];
}
