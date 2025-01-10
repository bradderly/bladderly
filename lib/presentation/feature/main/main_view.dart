import 'package:bradderly/presentation/feature/diary/diary/diary_view.dart';
import 'package:bradderly/presentation/feature/home/home_view.dart';
import 'package:bradderly/presentation/feature/main/widget/main_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late final pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // _buildBackground(context),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: const [
              HomeView(),
              DiaryView(),
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
