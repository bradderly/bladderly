part of 'sign_up_method_form_cubit.dart';

class SignUpMethodFormState extends Equatable {
  const SignUpMethodFormState({
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
    return email.validateEmail();
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
    return RegExp(r'[!@#$%^&*(),.?":{}|<>-]').hasMatch(password);
  }

  SignUpMethodFormState copyWith({
    String? email,
    String? password,
    bool? obsecurePassword,
  }) {
    return SignUpMethodFormState(
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
