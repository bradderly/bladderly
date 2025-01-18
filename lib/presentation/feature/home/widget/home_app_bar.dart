import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/generated/assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
    required this.onTapMenu,
  });

  static double get height => 66;

  final VoidCallback onTapMenu;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height + MediaQuery.paddingOf(context).top,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.colorTheme.vermilion.primary.shade40,
            context.colorTheme.vermilion.primary.shade40,
            context.colorTheme.vermilion.primary.shade40.withValues(alpha: 0),
          ],
          stops: const [0, 0.74, 1],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Row(
        children: [
          const Gap(24),
          Assets.icon.icIntroLogo.svg(),
          const Spacer(),
          IconButton(
            onPressed: onTapMenu,
            icon: Assets.icon.icHomeMenu.svg(),
          ),
          const Gap(8),
        ],
      ),
    );
  }
}
