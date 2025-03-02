// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:gap/gap.dart';
import 'package:nil/nil.dart';

// Project imports:
import 'package:bladderly/domain/model/sign_up_method.dart';
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';

class SignInSocialSigninButtonWidget extends StatelessWidget {
  const SignInSocialSigninButtonWidget({
    super.key,
    required this.onTap,
  });

  final void Function(SignUpMethod) onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              Expanded(child: Container(height: 1, color: context.colorTheme.neutral.shade6)),
              const Gap(12),
              Text(
                'or',
                style: context.textStyleTheme.b14SemiBold.copyWith(color: context.colorTheme.neutral.shade6),
              ),
              const Gap(12),
              Expanded(child: Container(height: 1, color: context.colorTheme.neutral.shade6)),
            ],
          ),
        ),
        const Gap(24),
        Column(
          children: List.generate(
            SignUpMethod.socialValues.length * 2 - 1,
            (index) {
              if (index.isOdd) return const Gap(16);

              final signinMethod = SignUpMethod.socialValues[index ~/ 2];

              return OutlinedButton(
                onPressed: () => onTap(signinMethod),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: context.colorTheme.neutral.shade10),
                  fixedSize: const Size.fromHeight(56),
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                ),
                child: Row(
                  children: [
                    getIcon(signinMethod),
                    Expanded(
                      child: Center(
                        child: Text(
                          switch (signinMethod) {
                            SignUpMethod.G => 'Continue with Google',
                            SignUpMethod.A => 'Continue with Apple',
                            _ => throw Exception('Invalid sign in method'),
                          },
                          style: context.textStyleTheme.b16SemiBold.copyWith(
                            color: context.colorTheme.neutral.shade10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget getIcon(SignUpMethod signUpMethod) {
    return switch (signUpMethod) {
      SignUpMethod.G => Assets.img.imgSigninGoogle.image(width: 36, height: 36),
      SignUpMethod.A => Assets.icon.icSigninApple.svg(width: 36, height: 36),
      _ => const Nil(),
    };
  }
}
