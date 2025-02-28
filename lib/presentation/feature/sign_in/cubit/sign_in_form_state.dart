part of 'sign_in_form_cubit.dart';

class SignInFormState extends Equatable {
  const SignInFormState({
    this.email = '',
    this.password = '',
    this.obscurePassword = true,
  });

  final String email;
  final String password;
  final bool obscurePassword;

  SignInFormState copyWith({
    String? email,
    String? password,
    bool? obscurePassword,
  }) {
    return SignInFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      obscurePassword: obscurePassword ?? this.obscurePassword,
    );
  }

  bool get isValid => email.isNotEmpty && password.isNotEmpty;

  @override
  List<Object> get props => [
        email,
        password,
        obscurePassword,
      ];
}
