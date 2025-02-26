import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/extension/string_extension.dart';
import 'package:bradderly/presentation/feature/signin/model/signin_method_model.dart';
import 'package:bradderly/presentation/generated/assets/assets.gen.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

class SigninSocialSigninButtonWidget extends StatelessWidget {
  const SigninSocialSigninButtonWidget({
    super.key,
    required this.onTap,
  });

  final void Function(SigninSocialMethodModel) onTap;

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
            SigninSocialMethodModel.socialMethods.length * 2 - 1,
            (index) {
              if (index.isOdd) return const Gap(16);

              final signinMethod = SigninSocialMethodModel.socialMethods[index ~/ 2];

              return Container(
                height: 56,
                padding: const EdgeInsets.symmetric(horizontal: 28),
                decoration: BoxDecoration(
                  border: Border.all(color: context.colorTheme.neutral.shade10),
                  borderRadius: BorderRadius.circular(400),
                ),
                child: Row(
                  children: [
                    getIcon(signinMethod),
                    Expanded(
                      child: Center(
                        child: Text(
                          signinMethod.text.tr(context),
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

  Widget getIcon(SigninSocialMethodModel signinMethodModel) {
    return switch (signinMethodModel) {
      SigninSocialMethodModel.google => Assets.icon.icSigninApple.svg(width: 36, height: 36),
      SigninSocialMethodModel.apple => Assets.img.imgSigninGoogle.image(width: 36, height: 36),
    };
  }
}
