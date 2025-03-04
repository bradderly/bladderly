// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:bladderly/domain/model/sex.dart';
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/widget/primary_button.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';

abstract class HowToUsePageView extends StatelessWidget {
  factory HowToUsePageView({
    required PageController pageController,
    required Gender gender,
  }) {
    return switch (gender) {
      Gender.female => _HowToUseFemalePageView(
          pageController: pageController,
        ),
      Gender.male => _HowToUseMalePageView(
          pageController: pageController,
        ),
    };
  }

  const HowToUsePageView._({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  List<({String desc, AssetGenImage image, String title})> get _data;

  double _getTextHeight(BuildContext context, String text, TextStyle style) {
    final textPainter = TextPainter(
      text: TextSpan(text: text.tr(context), style: style),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: MediaQuery.sizeOf(context).width - 48);

    return textPainter.size.height;
  }

  TextStyle _getTitleTextStyle(BuildContext context) {
    return context.textStyleTheme.b24Bold.copyWith(color: context.colorTheme.neutral.shade10);
  }

  TextStyle _getDescTextStyle(BuildContext context) {
    return context.textStyleTheme.b14SemiBold.copyWith(color: context.colorTheme.neutral.shade7);
  }

  @override
  Widget build(BuildContext context) {
    final textHeight = _data
        .map(
          (data) =>
              _getTextHeight(context, data.title, _getTitleTextStyle(context)) +
              switch (_getTextHeight(context, data.desc, _getDescTextStyle(context))) {
                0 => 0,
                final double height => 14 + height,
              },
        )
        .reduce((prev, curr) => prev > curr ? prev : curr);

    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: pageController,
            itemCount: _data.length,
            itemBuilder: (context, index) {
              final data = _data[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(40),
                    Expanded(child: Center(child: data.image.image())),
                    const Gap(40),
                    SizedBox(
                      height: textHeight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (data.title.isNotEmpty)
                            Text(
                              data.title.tr(context),
                              style: _getTitleTextStyle(context),
                            ),
                          if (data.desc.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 14),
                              child: Text(
                                data.desc.tr(context),
                                style: _getDescTextStyle(context),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const Gap(40),
        ListenableBuilder(
          listenable: pageController,
          builder: (context, _) {
            final pageIndex = pageController.page?.round() ?? 0;
            final isLastPage = pageIndex == _data.length - 1;
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _data.length * 2 - 1,
                    (index) => index.isOdd
                        ? const Gap(12)
                        : Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: pageIndex == index ~/ 2
                                  ? context.colorTheme.vermilion.primary.shade50
                                  : context.colorTheme.neutral.shade4,
                            ),
                          ),
                  ),
                ),
                const Gap(44),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: PrimaryButton.filled(
                    onPressed: () {
                      if (isLastPage) {
                        return context.pop<bool>(true);
                      }

                      pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    shape: BoxShape.rectangle,
                    borderRadius: 400,
                    backgroundColor: context.colorTheme.vermilion.primary.shade50,
                    text: isLastPage ? 'Done'.tr(context) : 'Next'.tr(context),
                    textColor: context.colorTheme.neutral.shade0,
                    size: const Size.fromHeight(56),
                  ),
                ),
              ],
            );
          },
        ),
        const Gap(44),
      ],
    );
  }
}

class _HowToUseFemalePageView extends HowToUsePageView {
  const _HowToUseFemalePageView({
    required super.pageController,
  }) : super._();

  @override
  List<({String desc, AssetGenImage image, String title})> get _data => [
        (
          image: Assets.img.imgHowToUseFemale1,
          title: 'Check the toilet water level',
          desc: 'Use this feature only with toilets that have enough water.',
        ),
        (
          image: Assets.img.imgHowToUseFemale2,
          title: 'Find a quiet bathroom',
          desc: 'For better accuracy, avoid sounds like TV, chatter, vent fans, running water, coughing, or groaning.',
        ),
        (image: Assets.img.imgHowToUseFemale3, title: 'Sit farther back than usual', desc: ''),
        (
          image: Assets.img.imgHowToUseFemale4,
          title: 'Knees shoulder-width apart',
          desc: 'Ensure you can see the water in the toilet bowl.',
        ),
        (
          image: Assets.img.imgHowToUseFemale5,
          title: 'Hold your phone on your lap',
          desc: 'Ensure the microphone is facing the toilet bowl.',
        ),
        (
          image: Assets.img.imgHowToUseFemale6,
          title: 'Press ‘Sound Input’',
          desc: 'Then start urinating.',
        ),
      ];
}

class _HowToUseMalePageView extends HowToUsePageView {
  const _HowToUseMalePageView({
    required super.pageController,
  }) : super._();

  @override
  List<({String desc, AssetGenImage image, String title})> get _data => [
        (
          image: Assets.img.imgHowToUseMale1,
          title: 'Check the toilet water level',
          desc: 'Use this feature only with toilets that have enough water.'
        ),
        (image: Assets.img.imgHowToUseMale2, title: 'Place the phone 2-3 feet from the toilet water', desc: ''),
        (image: Assets.img.imgHowToUseMale3, title: 'Press ‘Sound Input’ to begin recording', desc: ''),
        (image: Assets.img.imgHowToUseMale4, title: 'Aim at the center of the water while standing', desc: ''),
        (image: Assets.img.imgHowToUseMale5, title: 'Press ‘Stop Recording’ button before flushing', desc: ''),
        (image: Assets.img.imgHowToUseMale6, title: 'Now flush the toilet', desc: ''),
      ];
}
