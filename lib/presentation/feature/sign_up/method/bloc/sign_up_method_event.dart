part of 'sign_up_method_bloc.dart';

sealed class SignUpMethodEvent extends Equatable {
  const SignUpMethodEvent();
}

class SignUpMethodSelect extends SignUpMethodEvent {
  const SignUpMethodSelect(this.method);

  final SignUpMethod method;

  @override
  List<Object?> get props => [
        method,
      ];
}

class SignUpMethodCheckDuplicateEmail extends SignUpMethodEvent {
  const SignUpMethodCheckDuplicateEmail({
    required this.method,
    required this.email,
  });

  final SignUpMethod method;
  final String email;

  @override
  List<Object?> get props => [
        method,
        email,
      ];
}
