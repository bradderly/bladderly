// Flutter imports:
// Project imports:
import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/locale/app_locale.dart';
import 'package:bladderly/presentation/common/widget/primary_button.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';
import 'package:bladderly/presentation/router/route/about_route.dart';
import 'package:bladderly/presentation/router/route/intro_route.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:gap/gap.dart';

class IntroView extends StatelessWidget {
  const IntroView({super.key});

  @override
  Widget build(BuildContext context) {
    TextSpan getLinkText(String text, bool isToU) {
      return TextSpan(
        text: text,
        recognizer: TapGestureRecognizer()
          ..onTap = () => isToU ? const TermsRoute().push<void>(context) : const PrivacyRoute().push<void>(context),
        style: TextStyle(
          color: context.colorTheme.vermilion.primary.shade50,
          decoration: TextDecoration.underline,
        ),
      );
    }

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
                    Assets.img.imgIntroMain.image(),
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
                      'Make tracking enjoyable.'.tr(context),
                      style: context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade8),
                    ),
                    const Gap(32),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: RichText(
                        text: TextSpan(
                          style: context.textStyleTheme.b12Medium
                              .copyWith(color: context.colorTheme.neutral.shade6, height: 1.5),
                          children: switch (context.locale) {
                            AppLocale.en => [
                                const TextSpan(text: 'By continuing, you agree to Bladderly’s '),
                                getLinkText('Terms of Use', true),
                                const TextSpan(text: ' and '),
                                getLinkText('Privacy Policy', false),
                              ],
                            AppLocale.ko => [
                                const TextSpan(text: '계속 진행하면 블래덜리의 '),
                                getLinkText('이용약관', true),
                                const TextSpan(text: '과'),
                                getLinkText('개인정보 처리방침', false),
                                const TextSpan(text: '을 확인하였으며 이에 동의한 것으로 간주됩니다.'),
                              ],
                          },
                        ),
                      ),
                    ),
                    const Gap(32),
                    PrimaryButton.filled(
                      onPressed: () => const SignUpGuestRoute().go(context),
                      backgroundColor: context.colorTheme.vermilion.primary.shade50,
                      borderRadius: 400,
                      shape: BoxShape.rectangle,
                      text: 'I’m new here'.tr(context),
                      textColor: context.colorTheme.neutral.shade0,
                      size: const Size.fromHeight(56),
                    ),
                    const Gap(12),
                    GestureDetector(
                      onTap: () => const SignInRoute().go(context),
                      behavior: HitTestBehavior.translucent,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          'I already have an account'.tr(context),
                          style: context.textStyleTheme.b14SemiBold.copyWith(color: context.colorTheme.neutral.shade10),
                        ),
                      ),
                    ),
                    Gap(55 - 12 - MediaQuery.paddingOf(context).bottom),
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
