// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/feature/menu/widget/howtouse_page.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';

class HowtouseWoman extends StatefulWidget {
  const HowtouseWoman({super.key});

  @override
  State<HowtouseWoman> createState() => _HowtouseWomanState();
}

class _HowtouseWomanState extends State<HowtouseWoman> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<Map<String, String>> onboardingData = [
    {
      'image': 'assets/img/howtouse_woman1.png',
      'title': 'Quiet place makes accurate results.',
      'description':
          'For better accuracy, cut through the noise from the TV, chatter, vent fan, tap water, coughs, groaning, etc.',
    },
    {
      'image': 'assets/img/howtouse_woman2.png',
      'title': 'Sit on the toilet and knees shoulder-width apart.',
      'description': '',
    },
    {
      'image': 'assets/img/howtouse_woman3.png',
      'title': 'Check if you see the water in the toilet bowl.',
      'description': 'Sit back in a little bit than usual',
    },
    {
      'image': 'assets/img/howtouse_woman4.png',
      'title': 'Press ‘Sound Input’ to begin measurement',
      'description': '',
    },
    {
      'image': 'assets/img/howtouse_woman5.png',
      'title': 'Hold your phone in your hand and put it on your lap. Check the direction of the microphone',
      'description': '',
    },
  ];

  void _nextPage() {
    if (_currentPage < onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24, top: 14, right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Assets.icon.icIntroLogo.svg(
                    // ignore: deprecated_member_use_from_same_package
                    color: context.colorTheme.vermilion.primary.shade50,
                    width: 99,
                    height: 28,
                  ),
                  TextButton(
                    onPressed: () {
                      // Skip action
                    },
                    child: Text(
                      'Skip →',
                      style: context.textStyleTheme.b16SemiBold.copyWith(
                        color: context.colorTheme.vermilion.primary.shade50,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: onboardingData.length,
                itemBuilder: (context, index) => HowtousePage(
                  image: onboardingData[index]['image']!,
                  title: onboardingData[index]['title']!.tr(context),
                  description: onboardingData[index]['description']!.tr(context),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 44),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      onboardingData.length,
                      buildDot,
                    ),
                  ),
                  const SizedBox(height: 95),
                  ElevatedButton(
                    onPressed: _nextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.colorTheme.vermilion.primary.shade50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 100,
                        vertical: 15,
                      ),
                    ),
                    child: Text(
                      'Next',
                      style: context.textStyleTheme.b16SemiBold.copyWith(
                        color: context.colorTheme.neutral.shade0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDot(int index) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      height: 8,
      width: _currentPage == index ? 12 : 8,
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.orange : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }
}
