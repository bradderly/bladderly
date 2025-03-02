part of 'sign_up_regular_bloc.dart';

sealed class SignUpRegularState extends Equatable {
  const SignUpRegularState();

  @override
  List<Object> get props => [];
}

final class SignUpRegularInitial extends SignUpRegularState {
  const SignUpRegularInitial();
}

final class SignUpRegularSubmitInProgress extends SignUpRegularState {
  const SignUpRegularSubmitInProgress();
}

final class SignUpRegularSubmitSuccess extends SignUpRegularState {
  const SignUpRegularSubmitSuccess();
}

final class SignUpRegularSubmitFailure extends SignUpRegularState {
  const SignUpRegularSubmitFailure({
    required this.exception,
  });

  final Exception exception;

  @override
  List<Object> get props => [
        exception,
      ];
}
