import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/extension/string_extension.dart';
import 'package:bradderly/presentation/feature/menu/widget/howtouse_page.dart';
import 'package:bradderly/presentation/generated/assets/assets.gen.dart';
import 'package:flutter/material.dart';

class HowtouseMan extends StatefulWidget {
  const HowtouseMan({super.key});

  @override
  State<HowtouseMan> createState() => _HowtouseManState();
}

class _HowtouseManState extends State<HowtouseMan> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<Map<String, String>> onboardingData = [
    {
      'image': 'assets/img/howtouse_man1.png',
      'title': 'Place the phone 2-3 feet from the toilet water',
      'description': '',
    },
    {
      'image': 'assets/img/howtouse_man2.png',
      'title': 'Press ‘Sound Input’ to begin recording',
      'description': '',
    },
    {
      'image': 'assets/img/howtouse_man3.png',
      'title': 'Aim at the center of the water while standing',
      'description': '',
    },
    {
      'image': 'assets/img/howtouse_man4.png',
      'title': 'Press ‘Stop Recording’ button before flushing',
      'description': '',
    },
    {
      'image': 'assets/img/howtouse_man5.png',
      'title': 'Now flush the toilet',
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
                  description:
                      onboardingData[index]['description']!.tr(context),
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
                      backgroundColor:
                          context.colorTheme.vermilion.primary.shade50,
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
