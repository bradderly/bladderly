import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/extension/string_extension.dart';
import 'package:bradderly/presentation/common/widget/primary_button.dart';
import 'package:bradderly/presentation/generated/assets/assets.gen.dart';
import 'package:bradderly/presentation/router/route/onboarding_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Assets.img.imgOnboardingBg.image(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 25600),
                    Assets.icon.icOnboardingLogo.svg(),
                    const Gap(46),
                    Text(
                      'A novel way to manage your bladder diary.'.tr(context),
                      style: context.textStyleTheme.b20Bold.copyWith(color: context.colorTheme.neutral.shade0),
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(flex: 38028),
                  ],
                ),
                Positioned.fill(
                  top: null,
                  left: 24,
                  right: 24,
                  bottom: 68,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      PrimaryButton.filled(
                        onPressed: () => const SignupRoute().go(context),
                        size: const Size.fromHeight(56),
                        backgroundColor: context.colorTheme.neutral.shade0,
                        text: 'Create Account'.tr(context),
                        textColor: context.colorTheme.vermilion.primary.shade50,
                        borderRadius: 400,
                        shape: BoxShape.rectangle,
                      ),
                      const Gap(8),
                      PrimaryButton.outlined(
                        onPressed: () => const SigninRoute().go(context),
                        size: const Size.fromHeight(56),
                        text: 'Sign In'.tr(context),
                        textColor: context.colorTheme.neutral.shade0,
                        borderRadius: 400,
                        backgroundColor: Colors.transparent,
                        shape: BoxShape.rectangle,
                        borderColor: context.colorTheme.neutral.shade0,
                        borderWidth: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
