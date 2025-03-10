import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/widget/password_input_field.dart';
import 'package:bladderly/presentation/common/widget/primary_button.dart';
import 'package:bladderly/presentation/feature/forgot_password/widget/forgot_password_field_widget.dart';
import 'package:bladderly/presentation/feature/forgot_password/widget/forgot_password_verification_code_input_field.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:gap/gap.dart';

class ForgotPasswordResetPasswordView extends StatelessWidget {
  const ForgotPasswordResetPasswordView({
    super.key,
    required this.onResetPassword,
    required this.onChangedPassword,
    required this.onChangedConfirmPassword,
    required this.onChangedVerificationCode,
    required this.verificationCode,
    required this.isValidVerificationCode,
    required this.password,
    required this.confirmPassword,
    required this.isValidPassword,
    required this.onChangedObsecurePassword,
    required this.onChangedObsecureConfirmPassword,
    required this.obsecurePassword,
    required this.obsecureConfirmPassword,
  });

  final void Function(String verificationCode, String password, String confirmPassword) onResetPassword;
  final ValueChanged<String> onChangedPassword;
  final ValueChanged<String> onChangedConfirmPassword;
  final ValueChanged<String> onChangedVerificationCode;
  final ValueChanged<bool> onChangedObsecurePassword;
  final ValueChanged<bool> onChangedObsecureConfirmPassword;
  final String verificationCode;
  final bool isValidVerificationCode;
  final String password;
  final bool isValidPassword;
  final bool obsecurePassword;
  final String confirmPassword;
  final bool obsecureConfirmPassword;

  bool get _isValid => isValidVerificationCode && isValidPassword && password == confirmPassword;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(top: 30, bottom: 104),
          children: [
            Text(
              'Enter verification code sent to your email and set a new password.',
              style: context.textStyleTheme.b24Bold.copyWith(
                color: context.colorTheme.neutral.shade10,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(42),
            ForgotPasswordFieldWidget(
              text: 'Verification Code',
              child: ForgotPasswordVerificationCodeInputField(
                onChanged: onChangedVerificationCode,
                errorText: verificationCode.isEmpty || isValidVerificationCode
                    ? null
                    : 'Please enter 6-digit verification code.'.tr(context),
              ),
            ),
            const Gap(32),
            ForgotPasswordFieldWidget(
              text: 'New Password',
              child: PasswordInputField(
                onChanged: onChangedPassword,
                onToggleObsecureText: onChangedObsecurePassword,
                obsecureText: obsecurePassword,
                errorText: password.isEmpty || isValidPassword
                    ? null
                    : 'Your password should have at least 8 characters including at least one digit, one uppercase, and one special character.'
                        .tr(context),
              ),
            ),
            const Gap(32),
            ForgotPasswordFieldWidget(
              text: 'Confirm New Password',
              child: PasswordInputField(
                onChanged: onChangedConfirmPassword,
                onToggleObsecureText: onChangedObsecureConfirmPassword,
                obsecureText: obsecureConfirmPassword,
                errorText: password == confirmPassword ? null : 'Passwords do not match.'.tr(context),
              ),
            ),
          ],
        ),
        Positioned.fill(
          top: null,
          left: 24,
          right: 24,
          bottom: 28,
          child: KeyboardVisibilityBuilder(
            builder: (context, isKeyboardVisible) => isKeyboardVisible
                ? const SizedBox.shrink()
                : PrimaryButton.filled(
                    onPressed: _isValid ? () => onResetPassword(verificationCode, password, confirmPassword) : null,
                    backgroundColor:
                        _isValid ? context.colorTheme.vermilion.primary.shade50 : context.colorTheme.neutral.shade6,
                    borderRadius: 400,
                    shape: BoxShape.rectangle,
                    text: 'Submit'.tr(context),
                    textColor: context.colorTheme.neutral.shade0,
                    size: const Size.fromHeight(56),
                  ),
          ),
        ),
      ],
    );
  }
}
