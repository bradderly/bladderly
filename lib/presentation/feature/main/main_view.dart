import 'package:bradderly/presentation/feature/main/cubit/main_tab_cubit.dart';
import 'package:bradderly/presentation/feature/main/diary/diary_builder.dart';
import 'package:bradderly/presentation/feature/main/home/home_builder.dart';
import 'package:bradderly/presentation/feature/main/widget/main_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocListener<MainTabCubit, MainTabState>(
      listenWhen: (prev, curr) => prev.index != curr.index,
      listener: (context, state) => pageController.jumpToPage(state.index),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Scaffold(
            backgroundColor: Colors.transparent,
            body: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              children: [
                HomeBuilder(
                  onPressedMoreVoiding: () =>
                      context.read<MainTabCubit>().showDiary(scrollSection: MainTabDiaryScrollScetion.voiding),
                  onPressedMoreIntake: () =>
                      context.read<MainTabCubit>().showDiary(scrollSection: MainTabDiaryScrollScetion.intake),
                ),
                const DiaryBuilder(),
              ],
            ),
            bottomNavigationBar: BlocBuilder<MainTabCubit, MainTabState>(
              builder: (context, state) => MainBottomNavigationBar(
                onTap: context.read<MainTabCubit>().showIndex,
                currentIndex: state.index,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
