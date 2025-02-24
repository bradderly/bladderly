import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/extension/string_extension.dart';
import 'package:bradderly/presentation/common/locale/app_locale.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SignupGuestHeaderWidget extends StatelessWidget {
  const SignupGuestHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'You’re not alone.'.tr(context),
          style: context.textStyleTheme.b24Bold.copyWith(
            color: context.colorTheme.neutral.shade10,
          ),
        ),
        const Gap(24),
        Text(
          'Let’s take it step by step together to better days.'.tr(context),
          style: context.textStyleTheme.b16Medium.copyWith(
            color: context.colorTheme.neutral.shade10,
          ),
        ),
        Gap(
          switch (context.locale) {
            AppLocale.en => 16,
            AppLocale.ko => 8,
          },
        ),
        Text(
          'First, we’d like to get to know you.'.tr(context),
          style: context.textStyleTheme.b16Medium.copyWith(
            color: context.colorTheme.neutral.shade10,
          ),
        ),
      ],
    );
  }
}
