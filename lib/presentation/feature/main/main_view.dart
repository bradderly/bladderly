import 'package:bradderly/presentation/feature/diary/diary/diary_builder.dart';
import 'package:bradderly/presentation/feature/diary/diary/model/diary_view_scroll_section_model.dart';
import 'package:bradderly/presentation/feature/home/home_builder.dart';
import 'package:bradderly/presentation/feature/main/widget/main_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late final pageController = PageController();

  final scrollSectionNotifier = ValueNotifier(DiaryViewScrollSectionModel.none);

  @override
  void dispose() {
    pageController.dispose();
    scrollSectionNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Scaffold(
          backgroundColor: Colors.transparent,
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              HomeBuilder(
                onPressedMoreVoiding: () {
                  scrollSectionNotifier.value = DiaryViewScrollSectionModel.voiding;
                  pageController.jumpToPage(1);
                },
                onPressedMoreIntake: () {
                  scrollSectionNotifier.value = DiaryViewScrollSectionModel.intake;
                  pageController.jumpToPage(1);
                },
              ),
              ListenableBuilder(
                listenable: scrollSectionNotifier,
                builder: (_, __) => DiaryBuilder(
                  scrollSection: scrollSectionNotifier.value,
                  onApplyScrollSection: () => scrollSectionNotifier.value = DiaryViewScrollSectionModel.none,
                ),
              ),
            ],
          ),
          bottomNavigationBar: MainBottomNavigationBar(
            pageController: pageController,
          ),
        ),
      ],
    );
  }
}
