part of 'sign_up_method_bloc.dart';

sealed class SignUpMethodState extends Equatable {
  const SignUpMethodState();

  @override
  List<Object?> get props => [];
}

final class SignUpMethodInitial extends SignUpMethodState {
  const SignUpMethodInitial();
}

final class SignUpMethodSelectInProgress extends SignUpMethodState {
  const SignUpMethodSelectInProgress({
    required this.method,
  });
  final SignUpMethod method;

  @override
  List<Object?> get props => [
        method,
      ];
}

final class SignUpMethodSelectSuccess extends SignUpMethodState {
  const SignUpMethodSelectSuccess({
    required this.method,
    this.email,
  });

  final SignUpMethod method;
  final String? email;

  bool get shouldInputAccountInfo => method == SignUpMethod.E;

  @override
  List<Object?> get props => [
        ...super.props,
        method,
        email,
      ];
}

final class SignUpMethodSelectFailure extends SignUpMethodState {
  const SignUpMethodSelectFailure({
    required this.exception,
    required this.method,
  });

  final Exception exception;
  final SignUpMethod method;

  @override
  List<Object> get props => [
        exception,
        method,
      ];
}
