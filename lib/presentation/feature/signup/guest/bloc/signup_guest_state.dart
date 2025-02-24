part of 'signup_guest_bloc.dart';

sealed class SignupGuestState extends Equatable {
  const SignupGuestState();

  @override
  List<Object> get props => [];
}

final class SignupGuestInitial extends SignupGuestState {
  const SignupGuestInitial();
}

final class SignupGuestSubmitInProgress extends SignupGuestState {
  const SignupGuestSubmitInProgress();
}

final class SignupGuestSubmitSuccess extends SignupGuestState {
  const SignupGuestSubmitSuccess({
    required this.userModel,
  });

  final UserModel userModel;

  @override
  List<Object> get props => [
        ...super.props,
        userModel,
      ];
}

final class SignupGuestSubmitFailure extends SignupGuestState {
  const SignupGuestSubmitFailure({required this.exception});

  final Exception exception;

  @override
  List<Object> get props => [
        ...super.props,
        exception,
      ];
}
