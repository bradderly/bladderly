import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/locale/app_locale.dart';
import 'package:bradderly/presentation/generated/assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class IntroPageView extends StatelessWidget {
  const IntroPageView({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: [
        _FirstPage(),
        _SecondPage(),
        _ThirdPage(),
      ],
    );
  }
}

abstract class _Page extends StatelessWidget {
  Widget get image;

  Widget buildBody(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        image,
        const Gap(43),
        buildBody(context),
      ],
    );
  }
}

class _FirstPage extends _Page {
  @override
  Widget get image => Assets.icon.icIntroFirst.svg();

  @override
  Widget buildBody(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: context.textStyleTheme.b18SemiBold.copyWith(color: context.colorTheme.neutral.shade9),
        children: switch (AppLocale.current) {
          AppLocale.en => [
              const TextSpan(text: 'Bladderly automatically tracks\n your '),
              TextSpan(
                text: 'urination frequency, volume,\n',
                style: TextStyle(color: context.colorTheme.vermilion.primary.shade50),
              ),
              const TextSpan(text: 'and '),
              TextSpan(
                text: 'fluid intake ',
                style: TextStyle(color: context.colorTheme.vermilion.primary.shade50),
              ),
              const TextSpan(text: 'effortlessly!'),
            ],
          AppLocale.ko => [
              const TextSpan(text: '블래덜리는 '),
              TextSpan(
                text: '배뇨 빈도, 배뇨량',
                style: TextStyle(color: context.colorTheme.vermilion.primary.shade50),
              ),
              const TextSpan(text: '그리고\n'),
              TextSpan(
                text: '수분 섭취량을 ',
                style: TextStyle(color: context.colorTheme.vermilion.primary.shade50),
              ),
              const TextSpan(text: '자동으로 추적하여\n손쉽게 관리할 수 있습니다!'),
            ],
        },
      ),
    );
  }
}

class _SecondPage extends _Page {
  @override
  Widget get image => Assets.icon.icIntroSecond.svg();

  @override
  Widget buildBody(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: context.textStyleTheme.b18SemiBold.copyWith(color: context.colorTheme.neutral.shade9),
        children: switch (AppLocale.current) {
          AppLocale.en => [
              const TextSpan(text: 'Simply by analyzing\n'),
              TextSpan(
                text: 'toilet sound.',
                style: TextStyle(color: context.colorTheme.vermilion.primary.shade50),
              ),
              const TextSpan(text: 'Much more\n'),
              TextSpan(
                text: 'convenient',
                style: TextStyle(color: context.colorTheme.vermilion.primary.shade50),
              ),
              const TextSpan(text: ' and '),
              TextSpan(
                text: 'sanitary!',
                style: TextStyle(color: context.colorTheme.vermilion.primary.shade50),
              ),
            ],
          AppLocale.ko => [
              TextSpan(
                text: '배뇨컵 없이 소리로 기록',
                style: TextStyle(color: context.colorTheme.vermilion.primary.shade50),
              ),
              const TextSpan(text: '이 가능하여\n훨씬 더 편리하고 위생적입니다.'),
            ],
        },
      ),
    );
  }
}

class _ThirdPage extends _Page {
  @override
  Widget get image => Assets.icon.icIntroThird.svg();

  @override
  @override
  Widget buildBody(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: context.textStyleTheme.b18SemiBold.copyWith(color: context.colorTheme.neutral.shade9),
        children: switch (AppLocale.current) {
          AppLocale.en => [
              TextSpan(
                text: 'Get a full, true picture ',
                style: TextStyle(color: context.colorTheme.vermilion.primary.shade50),
              ),
              const TextSpan(text: 'of your\nbladder control.'),
            ],
          AppLocale.ko => [
              const TextSpan(
                text: '블래덜리와 함께 ',
              ),
              TextSpan(
                text: '배뇨패턴과 건강상태',
                style: TextStyle(color: context.colorTheme.vermilion.primary.shade50),
              ),
              const TextSpan(text: '를\n'),
              TextSpan(
                text: '편리',
                style: TextStyle(color: context.colorTheme.vermilion.primary.shade50),
              ),
              const TextSpan(text: '하고 '),
              TextSpan(
                text: '정확',
                style: TextStyle(color: context.colorTheme.vermilion.primary.shade50),
              ),
              const TextSpan(text: '하게 확인해보세요!'),
            ],
        },
      ),
    );
  }
}
