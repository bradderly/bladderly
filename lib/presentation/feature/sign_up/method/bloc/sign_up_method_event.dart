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
