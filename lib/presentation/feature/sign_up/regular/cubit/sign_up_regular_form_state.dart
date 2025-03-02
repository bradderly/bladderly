part of 'sign_up_regular_form_cubit.dart';

class SignUpRegularFormState extends Equatable {
  const SignUpRegularFormState({
    this.email = '',
    this.password = '',
    this.obsecurePassword = true,
  });

  final String email;
  final String password;
  final bool obsecurePassword;

  bool get isValid {
    return isEmailValid && isPasswordValid;
  }

  bool get isEmailValid {
    return RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(email);
  }

  bool get isPasswordValid {
    return isPasswordAtLeast8Characters &&
        isPasswordAtLeastOneDigit &&
        isPasswordAtLeastOneUppercase &&
        isPasswordAtLeastOneSpecialCharacter;
  }

  bool get isPasswordAtLeast8Characters {
    return password.length >= 8;
  }

  bool get isPasswordAtLeastOneDigit {
    return RegExp('[0-9]').hasMatch(password);
  }

  bool get isPasswordAtLeastOneUppercase {
    return RegExp('[A-Z]').hasMatch(password);
  }

  bool get isPasswordAtLeastOneSpecialCharacter {
    return RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
  }

  SignUpRegularFormState copyWith({
    String? email,
    String? password,
    bool? obsecurePassword,
  }) {
    return SignUpRegularFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      obsecurePassword: obsecurePassword ?? this.obsecurePassword,
    );
  }

  @override
  List<Object> get props => [
        email,
        password,
        obsecurePassword,
      ];
}
