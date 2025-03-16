import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/widget/email_address_input_field.dart';
import 'package:bladderly/presentation/common/widget/primary_button.dart';
import 'package:bladderly/presentation/feature/forgot_password/widget/forgot_password_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:gap/gap.dart';

class ForgotPasswordSendVerificationCodeView extends StatelessWidget {
  const ForgotPasswordSendVerificationCodeView({
    super.key,
    required this.onSendVerificationCode,
    required this.onChangedEamil,
    required this.email,
    required this.isValid,
  });

  final void Function(String) onSendVerificationCode;
  final ValueChanged<String> onChangedEamil;
  final String email;
  final bool isValid;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(top: 30, bottom: 104),
          children: [
            Text(
              'We will email you a verification code to reset your password'.tr(context),
              style: context.textStyleTheme.b24Bold.copyWith(
                color: context.colorTheme.neutral.shade10,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(42),
            ForgotPasswordFieldWidget(
              text: 'Email Address'.tr(context),
              child: EmailAddressInputField(
                onChanged: onChangedEamil,
                email: email,
                errorText:
                    email.isEmpty || isValid ? null : 'Please enter a properly formatted email address.'.tr(context),
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
                    onPressed: isValid ? () => onSendVerificationCode(email) : null,
                    backgroundColor:
                        isValid ? context.colorTheme.vermilion.primary.shade50 : context.colorTheme.neutral.shade6,
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
