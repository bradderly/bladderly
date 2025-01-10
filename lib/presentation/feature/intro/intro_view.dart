import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/extension/string_extension.dart';
import 'package:bradderly/presentation/common/widget/primary_button.dart';
import 'package:bradderly/presentation/feature/intro/widget/intro_page_view.dart';
import 'package:bradderly/presentation/generated/assets/assets.gen.dart';
import 'package:bradderly/presentation/router/route/onboarding_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class IntroView extends StatefulWidget {
  const IntroView({super.key});

  @override
  State<IntroView> createState() => _IntroViewState();
}

class _IntroViewState extends State<IntroView> {
  final pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void goNextPage() {
    final pageIndex = pageController.page?.ceil() ?? 0;
    final isLastPage = pageIndex >= (pageController.viewportFraction / pageController.position.maxScrollExtent) + 1;

    if (isLastPage) {
      return const OnboardingRoute().go(context);
    }

    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Assets.img.imgIntroBg.image(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: const SizedBox(width: 12),
            leadingWidth: 12,
            backgroundColor: Colors.transparent,
            centerTitle: false,
            toolbarHeight: 66,
            title: Assets.icon.icIntroLogo.svg(),
          ),
          body: SafeArea(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  top: 200 - MediaQuery.paddingOf(context).top,
                  child: IntroPageView(pageController: pageController),
                ),
                Positioned.fill(
                  top: null,
                  bottom: 28,
                  child: Column(
                    children: [
                      _buildIndicator(),
                      const Gap(32),
                      SizedBox(
                        width: 256,
                        height: 43,
                        child: PrimaryButton.filled(
                          onPressed: goNextPage,
                          borderRadius: 8,
                          backgroundColor: context.colorTheme.vermilion.primary.shade50,
                          shape: BoxShape.rectangle,
                          text: 'Continue'.tr,
                          textColor: context.colorTheme.neutral.shade0,
                        ),
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

  Widget _buildIndicator() {
    return ListenableBuilder(
      listenable: pageController,
      builder: (_, __) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          5,
          (index) {
            if (index.isOdd) return const Gap(12);

            final dotIndex = index ~/ 2;
            final pageIndex = pageController.hasClients ? (pageController.page?.round() ?? 0) : 0;
            final isActive = dotIndex == pageIndex;

            return _buildDot(isActive: isActive);
          },
        ),
      ),
    );
  }

  Widget _buildDot({required bool isActive}) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? context.colorTheme.vermilion.primary.shade50 : context.colorTheme.neutral.shade4,
      ),
    );
  }
}
