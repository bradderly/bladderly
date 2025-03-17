import 'dart:io';

import 'package:bladderly/domain/model/sign_up_method.dart';
import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/widget/primary_button.dart';
import 'package:bladderly/presentation/common/widget/social_signin_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';

class SignUpMethodWidget extends StatelessWidget {
  const SignUpMethodWidget({
    super.key,
    required this.onSignUp,
  });

  final void Function(SignUpMethod) onSignUp;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sign up'.tr(context),
            style: context.textStyleTheme.b24Bold.copyWith(color: context.colorTheme.neutral.shade10),
          ),
          const Gap(24),
          Text(
            'Just 3 seconds is enough. Sign up and store your data for free and securely!'.tr(context),
            style: context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade10),
          ),
          const Spacer(),
          PrimaryButton.filled(
            onPressed: () => onSignUp(SignUpMethod.E),
            backgroundColor: context.colorTheme.vermilion.primary.shade50,
            borderRadius: 400,
            shape: BoxShape.rectangle,
            text: 'Continue with Email'.tr(context),
            textColor: context.colorTheme.neutral.shade0,
            size: const Size.fromHeight(56),
          ),
          const Gap(32),
          SocialSigninButtonWidget(
            onTap: onSignUp,
          ),
          if (Platform.isAndroid) const Gap(72),
        ],
      ),
    );
  }
}
