part of 'change_password_form_cubit.dart';

class ChangePasswordFormState extends Equatable {
  const ChangePasswordFormState({
    this.oldPassword = '',
    this.newPassword = '',
    this.confirmPassword = '',
    this.obscureOldPassword = true,
    this.obscureNewPassword = true,
    this.obscureConfirmPassword = true,
  });

  final String oldPassword;
  final String newPassword;
  final String confirmPassword;
  final bool obscureOldPassword;
  final bool obscureNewPassword;
  final bool obscureConfirmPassword;

  ChangePasswordFormState copyWith({
    String? oldPassword,
    String? newPassword,
    String? confirmPassword,
    bool? obscureOldPassword,
    bool? obscureNewPassword,
    bool? obscureConfirmPassword,
  }) {
    return ChangePasswordFormState(
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      obscureOldPassword: obscureOldPassword ?? this.obscureOldPassword,
      obscureNewPassword: obscureNewPassword ?? this.obscureNewPassword,
      obscureConfirmPassword: obscureConfirmPassword ?? this.obscureConfirmPassword,
    );
  }

  bool get isValid => oldPassword.isNotEmpty && newPassword.isNotEmpty && confirmPassword.isNotEmpty;

  @override
  List<Object> get props => [
        oldPassword,
        newPassword,
        confirmPassword,
        obscureOldPassword,
        obscureNewPassword,
        obscureConfirmPassword,
      ];
}
