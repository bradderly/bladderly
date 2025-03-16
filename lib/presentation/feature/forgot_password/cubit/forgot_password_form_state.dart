part of 'forgot_password_form_cubit.dart';

class ForgotPasswordFormState extends Equatable {
  const ForgotPasswordFormState({
    this.email = '',
    this.verificationCode = '',
    this.password = '',
    this.obsecurePassword = true,
    this.confirmPassword = '',
    this.obsecureConfirmPassword = true,
  });

  final String email;
  final String verificationCode;
  final String password;
  final bool obsecurePassword;
  final String confirmPassword;
  final bool obsecureConfirmPassword;

  ForgotPasswordFormState copyWith({
    String? email,
    String? verificationCode,
    String? password,
    bool? obsecurePassword,
    String? confirmPassword,
    bool? obsecureConfirmPassword,
  }) {
    return ForgotPasswordFormState(
      email: email ?? this.email,
      verificationCode: verificationCode ?? this.verificationCode,
      password: password ?? this.password,
      obsecurePassword: obsecurePassword ?? this.obsecurePassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      obsecureConfirmPassword: obsecureConfirmPassword ?? this.obsecureConfirmPassword,
    );
  }

  bool get canSendVerificationCode => RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(email);

  bool get canResetPassword =>
      canSendVerificationCode && verificationCode.isNotEmpty && password.isNotEmpty && password == confirmPassword;

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
    return password.checkHasLeastOneSpecialCharacter;
  }

  bool get isVerficationCodeValid {
    return int.tryParse(verificationCode) != null && verificationCode.length == 6;
  }

  @override
  List<Object> get props => [
        email,
        verificationCode,
        password,
        obsecurePassword,
        confirmPassword,
        obsecureConfirmPassword,
      ];
}
