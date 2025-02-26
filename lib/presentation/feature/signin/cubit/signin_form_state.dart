part of 'signin_form_cubit.dart';

class SigninFormState extends Equatable {
  const SigninFormState({
    this.email = '',
    this.password = '',
    this.obscurePassword = false,
  });

  final String email;
  final String password;
  final bool obscurePassword;

  SigninFormState copyWith({
    String? email,
    String? password,
    bool? obscurePassword,
  }) {
    return SigninFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      obscurePassword: obscurePassword ?? this.obscurePassword,
    );
  }

  @override
  List<Object> get props => [
        email,
        password,
        obscurePassword,
      ];
}
