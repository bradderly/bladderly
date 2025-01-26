import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/extension/string_extension.dart';
import 'package:bradderly/presentation/feature/main/diary/model/diary_voding_summary_model.dart';
import 'package:bradderly/presentation/generated/assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DiaryVoidingSummaryWidget extends StatelessWidget {
  const DiaryVoidingSummaryWidget({
    super.key,
    required this.onExpand,
    required this.isExpanded,
    required this.diaryVodingSummaryModel,
  });

  final void Function(bool isExpanded) onExpand;
  final bool isExpanded;
  final DiaryVoidingSummaryModel diaryVodingSummaryModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const Gap(16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            decoration: BoxDecoration(
              color: context.colorTheme.neutral.shade0,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _buildTotalAmount(context),
                _buildDivider(),
                _buildFrequency(context),
                if (isExpanded) ...[
                  _buildDivider(),
                  _buildVoidedVolume(context),
                  _buildDivider(),
                  _buildVoidingInterval(context),
                ],
                const Gap(16),
                GestureDetector(
                  onTap: () => onExpand(!isExpanded),
                  child: ColoredBox(
                    color: context.colorTheme.neutral.shade0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RotatedBox(
                          quarterTurns: isExpanded ? 2 : 0,
                          child: Assets.icon.icDiaryDownArrow.svg(),
                        ),
                        Text(
                          isExpanded ? 'See less'.tr(context) : 'See more'.tr(context),
                          style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade7),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      color: Color(0xFFE6E6E6),
      height: 33,
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Text(
      'Voiding'.tr(context),
      style: context.textStyleTheme.b16SemiBold.copyWith(
        color: context.colorTheme.vermilion.primary.shade50,
      ),
    );
  }

  Widget _buildTotalAmount(BuildContext context) {
    return Row(
      children: [
        Text(
          'Total amount'.tr(context),
          style: context.textStyleTheme.b18SemiBold.copyWith(
            color: context.colorTheme.neutral.shade10,
          ),
        ),
        const Spacer(),
        RichText(
          text: TextSpan(
            style: context.textStyleTheme.b18SemiBold.copyWith(
              color: context.colorTheme.neutral.shade10,
            ),
            children: [
              const TextSpan(text: '0'),
              const WidgetSpan(child: SizedBox(width: 4)),
              TextSpan(text: context.unit),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFrequency(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Frequency'.tr(context),
          style: context.textStyleTheme.b16SemiBold.copyWith(
            color: context.colorTheme.neutral.shade10,
          ),
        ),
        const Gap(12),
        Row(
          children: List.generate(
            5,
            (index) {
              if (index.isOdd) return const Gap(8);

              final realIndex = index ~/ 2;

              final icons = [Assets.icon.icDiaryDaytime, Assets.icon.icDiaryNighttime, Assets.icon.icDiaryLeakage];
              final texts = ['Daytime', 'Night-time', 'Leakage'];

              return Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        icons[realIndex].svg(),
                        const Gap(4),
                        Text(
                          texts[realIndex].tr(context),
                          style: context.textStyleTheme.b14Medium.copyWith(
                            color: context.colorTheme.neutral.shade7,
                          ),
                        ),
                      ],
                    ),
                    const Gap(8),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: RichText(
                        text: TextSpan(
                          style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade10),
                          children: [
                            TextSpan(
                              text: '0',
                              style: context.textStyleTheme.b24Bold.copyWith(color: context.colorTheme.neutral.shade10),
                            ),
                            const TextSpan(text: ' '),
                            TextSpan(text: 'times'.tr(context)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildVoidedVolume(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Voided volume'.tr(context),
          style: context.textStyleTheme.b16SemiBold.copyWith(
            color: context.colorTheme.neutral.shade10,
          ),
        ),
        const Gap(12),
        Row(
          children: List.generate(
            5,
            (index) {
              if (index.isOdd) return const Gap(8);

              final realIndex = index ~/ 2;

              if (realIndex == 2) return const Spacer();

              return Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ['Max', 'Min'][realIndex].tr(context),
                      style: context.textStyleTheme.b14Medium
                          .copyWith(color: context.colorTheme.vermilion.primary.shade50),
                    ),
                    const Gap(8),
                    RichText(
                      text: TextSpan(
                        style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade10),
                        children: [
                          TextSpan(
                            text: '0',
                            style: context.textStyleTheme.b24Bold.copyWith(color: context.colorTheme.neutral.shade10),
                          ),
                          const TextSpan(text: ' '),
                          TextSpan(text: context.unit),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildVoidingInterval(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Voiding interval'.tr(context),
              style: context.textStyleTheme.b16SemiBold.copyWith(
                color: context.colorTheme.neutral.shade10,
              ),
            ),
            const Gap(5),
            Text(
              '(hr:mins)'.tr(context),
              style: context.textStyleTheme.b14SemiBold.copyWith(
                color: context.colorTheme.neutral.shade6,
              ),
            ),
          ],
        ),
        const Gap(12),
        Row(
          children: List.generate(
            5,
            (index) {
              if (index.isOdd) return const Gap(8);

              final realIndex = index ~/ 2;

              return Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ['Max', 'Mean', 'Min'][realIndex].tr(context),
                      style: context.textStyleTheme.b14Medium
                          .copyWith(color: context.colorTheme.vermilion.primary.shade50),
                    ),
                    const Gap(8),
                    Text(
                      '00:00',
                      style: context.textStyleTheme.b24Bold.copyWith(color: context.colorTheme.neutral.shade10),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
