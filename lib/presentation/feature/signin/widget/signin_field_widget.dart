import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SigninFieldWidget extends StatelessWidget {
  const SigninFieldWidget({
    super.key,
    required this.text,
    required this.child,
  });

  final String text;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: context.textStyleTheme.b14SemiBold.copyWith(
            color: context.colorTheme.neutral.shade6,
          ),
        ),
        const Gap(16),
        child,
      ],
    );
  }
}
