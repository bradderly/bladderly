import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/extension/string_extension.dart';
import 'package:flutter/material.dart';

enum _ManualInputTab {
  voiding(text: 'Voiding'),
  leakage(text: 'Leakage'),
  ;

  const _ManualInputTab({
    required this.text,
  });

  final String text;
}

class ManualInputTabBar extends StatelessWidget implements PreferredSizeWidget {
  const ManualInputTabBar({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Size get preferredSize => const Size.fromHeight(59);

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: pageController,
      builder: (context, _) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 19),
        child: SizedBox(
          height: 40,
          child: Row(
            children: List.generate(
              _ManualInputTab.values.length,
              (index) => _buildTabItem(
                context,
                isSelected: switch (pageController.hasClients) {
                  false => false,
                  true => (pageController.page?.round() ?? pageController.initialPage) == index,
                },
                tab: _ManualInputTab.values[index],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabItem(
    BuildContext context, {
    required bool isSelected,
    required _ManualInputTab tab,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          Future.delayed(
            const Duration(milliseconds: 100),
            () => pageController.jumpToPage(_ManualInputTab.values.indexOf(tab)),
          );
        },
        behavior: HitTestBehavior.translucent,
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                tab.text.tr(context),
                style: context.textStyleTheme.b16SemiBold.copyWith(
                  color: isSelected ? context.colorTheme.vermilion.primary.shade50 : context.colorTheme.neutral.shade6,
                ),
              ),
            ),
            if (isSelected)
              Positioned.fill(
                top: null,
                child: Container(
                  height: 2,
                  color: context.colorTheme.vermilion.primary.shade50,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
