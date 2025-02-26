import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/extension/string_extension.dart';
import 'package:bradderly/presentation/common/widget/primary_button.dart';
import 'package:bradderly/presentation/router/route/intro_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class IntroView extends StatelessWidget {
  const IntroView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFFC8150),
            Color(0xFFFAD3BB),
            Color(0xFFF8F8F7),
          ],
          stops: [0, 0.17, 0.5],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Text(
                      'Bladderly',
                      style: context.textStyleTheme.b24BoldOutfit
                          .copyWith(fontSize: 40, color: context.colorTheme.vermilion.primary.shade50),
                    ),
                    const Gap(4),
                    Text(
                      'Smart Bladder Diary'.tr(context),
                      style: context.textStyleTheme.b20Bold.copyWith(color: context.colorTheme.neutral.shade9),
                    ),
                    const Gap(16),
                    Text(
                      'Free yourself from the hassle of writing on paper.'.tr(context),
                      style: context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade8),
                    ),
                    const Gap(32),
                    PrimaryButton.filled(
                      onPressed: () => const SignupGuestRoute().go(context),
                      backgroundColor: context.colorTheme.vermilion.primary.shade50,
                      borderRadius: 400,
                      shape: BoxShape.rectangle,
                      text: 'I’m new here'.tr(context),
                      textColor: context.colorTheme.neutral.shade0,
                      size: const Size.fromHeight(56),
                    ),
                    const Gap(24),
                    GestureDetector(
                      onTap: () => const SigninRoute().go(context),
                      behavior: HitTestBehavior.translucent,
                      child: Text(
                        'I already have an account'.tr(context),
                        style: context.textStyleTheme.b14SemiBold.copyWith(color: context.colorTheme.neutral.shade10),
                      ),
                    ),
                    Gap(55 - MediaQuery.paddingOf(context).bottom),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
