import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/widget/cupertino_back_button.dart';
import 'package:bladderly/presentation/common/widget/parimary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SignUpRegularView extends StatelessWidget {
  const SignUpRegularView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CupertinoBackButton(),
        title: Text(
          'Sign Up'.tr(context),
          style: context.textStyleTheme.b16SemiBold.copyWith(color: context.colorTheme.neutral.shade10),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Gap(29),
            Center(
              child: Text(
                'Enter your email'.tr(context),
                style: context.textStyleTheme.b24BoldOutfit.copyWith(color: context.colorTheme.neutral.shade10),
                textAlign: TextAlign.center,
              ),
            ),
            const Gap(77),
            ParimaryTextField(
              errorText: 'Please enter a properly formatted email address.'.tr(context),
              label: 'Email Address'.tr(context),
            ),
          ],
        ),
      ),
    );
  }
}
