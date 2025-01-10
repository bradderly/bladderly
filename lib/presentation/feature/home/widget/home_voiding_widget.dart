import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/extension/string_extension.dart';
import 'package:bradderly/presentation/generated/assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeVoidingWidget extends StatelessWidget {
  const HomeVoidingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: const Color(0xFFFAF9F3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        shadows: context.shadowTheme.shadow1,
      ),
      child: Column(
        children: [
          _buildHeader(context),
          const Gap(24),
          _buildSummary(context),
          const Gap(24),
          Divider(color: context.colorTheme.neutral.shade4, thickness: 1),
          const Gap(12),
          _buildHowToUse(context),
          const Gap(12),
          _buildSoundInput(context, isActivated: true),
          const Gap(12),
          _buildManualInput(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Text(
          'Voiding'.tr,
          style: context.textStyleTheme.b20Bold.copyWith(color: context.colorTheme.neutral.shade10),
        ),
        const Spacer(),
        Text(
          'See more'.tr,
          style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade7),
        ),
      ],
    );
  }

  Widget _buildSummary(BuildContext context) {
    return Row(
      children: List.generate(
        5,
        (index) {
          if (index.isOdd) return const Gap(16);

          return Expanded(
            child: Column(
              children: [
                Text(
                  ['Frequency', 'Total void', 'Last record'][index ~/ 2].tr,
                  style: context.textStyleTheme.b14SemiBold.copyWith(color: context.colorTheme.neutral.shade7),
                ),
                const Gap(16),
                Text(
                  ['0', '0', 'N/A'][index ~/ 2],
                  style: context.textStyleTheme.b24Bold.copyWith(color: context.colorTheme.neutral.shade10),
                ),
                Text(
                  ['times', context.unit, 'ago'][index ~/ 2].tr,
                  style: context.textStyleTheme.b14SemiBold.copyWith(color: context.colorTheme.neutral.shade10),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHowToUse(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Stack(
          children: [
            Text(
              'How to use'.tr,
              style: context.textStyleTheme.b14SemiBold.copyWith(
                color: context.colorTheme.neutral.shade7,
              ),
            ),
            Positioned.fill(
              top: null,
              bottom: -6,
              child: Divider(
                color: context.colorTheme.neutral.shade7,
                thickness: 1.5,
              ),
            ),
          ],
        ),
        const Gap(4),
        Assets.icon.icHomeHelp.svg(),
      ],
    );
  }

  Widget _buildSoundInput(
    BuildContext context, {
    required bool isActivated,
  }) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 38),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          shadows: context.shadowTheme.shadow1,
        ),
        child: Row(
          children: [
            Text(
              'Sound Input'.tr,
              style: context.textStyleTheme.b20Bold.copyWith(color: context.colorTheme.neutral.shade10),
            ),
            const Spacer(),
            Assets.icon.icHomeSoundInput.svg(),
          ],
        ),
      ),
    );
  }

  Widget _buildManualInput(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          shadows: context.shadowTheme.shadow1,
        ),
        child: Row(
          children: [
            Text(
              'Manual Input'.tr,
              style: context.textStyleTheme.b20Bold.copyWith(color: context.colorTheme.neutral.shade10),
            ),
            const Spacer(),
            Assets.icon.icHomeManualInput.svg(),
          ],
        ),
      ),
    );
  }
}
