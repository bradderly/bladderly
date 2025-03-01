// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:gap/gap.dart';

// Project imports:
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';

class SignInFieldWidget extends StatelessWidget {
  const SignInFieldWidget({
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
