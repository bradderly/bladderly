import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/extension/string_extension.dart';
import 'package:bradderly/presentation/generated/assets/assets.gen.dart';
import 'package:flutter/material.dart';

class MainBottomNavigationBar extends StatelessWidget {
  const MainBottomNavigationBar({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: pageController,
      builder: (_, __) {
        final currentIndex = pageController.hasClients ? pageController.page?.round() ?? 0 : 0;

        return Container(
          padding: const EdgeInsets.only(top: 16),
          height: 73 + MediaQuery.paddingOf(context).bottom,
          decoration: BoxDecoration(
            color: context.colorTheme.neutral.shade0,
            border: Border(top: BorderSide(color: context.colorTheme.neutral.shade4)),
          ),
          child: Row(
            children: List.generate(
              2,
              (index) {
                final isSelected = currentIndex == index;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => pageController.jumpToPage(index),
                    child: ColoredBox(
                      color: Colors.transparent,
                      child: Column(
                        children: [
                          [Assets.icon.icMainHome.svg, Assets.icon.icMainDiary.svg][index](
                            colorFilter: ColorFilter.mode(
                              isSelected ? context.colorTheme.neutral.shade10 : context.colorTheme.neutral.shade6,
                              BlendMode.srcIn,
                            ),
                          ),
                          Text(
                            ['Home', 'Diary'][index].tr,
                            style: context.textStyleTheme.b12Medium.copyWith(
                              color:
                                  isSelected ? context.colorTheme.neutral.shade10 : context.colorTheme.neutral.shade6,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
