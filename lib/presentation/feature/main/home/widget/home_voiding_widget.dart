import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/feature/main/home/model/home_voiding_summary_model.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeVoidingWidget extends StatelessWidget {
  const HomeVoidingWidget({
    super.key,
    required this.onTapMore,
    required this.homeVoidingSummaryModel,
  });

  final VoidCallback onTapMore;
  final HomeVoidingSummaryModel homeVoidingSummaryModel;

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
          'Voiding'.tr(context),
          style: context.textStyleTheme.b20Bold.copyWith(color: context.colorTheme.neutral.shade10),
        ),
        const Spacer(),
        GestureDetector(
          onTap: onTapMore,
          child: ColoredBox(
            color: Colors.transparent,
            child: Text(
              'See more'.tr(context),
              style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade7),
            ),
          ),
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
                  ['Frequency', 'Total void', 'Last record'][index ~/ 2].tr(context),
                  style: context.textStyleTheme.b14SemiBold.copyWith(color: context.colorTheme.neutral.shade7),
                ),
                const Gap(16),
                Text(
                  [
                    '${homeVoidingSummaryModel.frequency}',
                    '${homeVoidingSummaryModel.totalVoid}',
                    homeVoidingSummaryModel.lastRecord,
                  ][index ~/ 2],
                  style: context.textStyleTheme.b24Bold.copyWith(color: context.colorTheme.neutral.shade10),
                ),
                Text(
                  [
                    if (homeVoidingSummaryModel.frequency < 2 && context.locale.isEn) 'time' else 'times'.tr(context),
                    context.unitName.tr(context),
                    'ago'.tr(context),
                  ][index ~/ 2],
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
              'How to use'.tr(context),
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
      onTap: () => const SoundInputRecordingRoute().push<void>(context),
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
              'Sound Input'.tr(context),
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
      onTap: () => const ManualInputRoute().push<void>(context),
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
              'Manual Input'.tr(context),
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
