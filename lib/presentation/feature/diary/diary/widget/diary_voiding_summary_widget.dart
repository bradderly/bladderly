import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/feature/diary/diary/model/diary_voding_summary_model.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

enum _FrequencyType {
  daytime(text: 'Daytime'),
  nighttime(text: 'Night-time'),
  leakage(text: 'Leakage'),
  ;

  const _FrequencyType({required this.text});

  final String text;

  SvgGenImage get icon {
    return switch (this) {
      _FrequencyType.daytime => Assets.icon.icDiaryDaytime,
      _FrequencyType.nighttime => Assets.icon.icDiaryNighttime,
      _FrequencyType.leakage => Assets.icon.icDiaryLeakage,
    };
  }
}

enum _VoidingVolumeType {
  max(text: 'Max'),
  min(text: 'Min'),
  ;

  const _VoidingVolumeType({required this.text});

  final String text;
}

enum _VoidingIntervalType {
  max(text: 'Max'),
  mean(text: 'Mean'),
  min(text: 'Min'),
  ;

  const _VoidingIntervalType({required this.text});

  final String text;
}

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
              TextSpan(text: '${context.unitValue(diaryVodingSummaryModel.totalVolume)}'),
              const WidgetSpan(child: SizedBox(width: 4)),
              TextSpan(text: context.unitName),
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

              final frequencyType = _FrequencyType.values[realIndex];

              return Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        frequencyType.icon.svg(),
                        const Gap(4),
                        Text(
                          frequencyType.text.tr(context),
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
                              text: switch (frequencyType) {
                                _FrequencyType.daytime => '${diaryVodingSummaryModel.daytimeFrequency}',
                                _FrequencyType.nighttime => '${diaryVodingSummaryModel.nighttimeFrequency}',
                                _FrequencyType.leakage => '${diaryVodingSummaryModel.leakageFrequency}',
                              },
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

              final voidingVolumeType = _VoidingVolumeType.values[realIndex];

              return Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      voidingVolumeType.text.tr(context),
                      style: context.textStyleTheme.b14Medium
                          .copyWith(color: context.colorTheme.vermilion.primary.shade50),
                    ),
                    const Gap(8),
                    RichText(
                      text: TextSpan(
                        style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade10),
                        children: [
                          TextSpan(
                            text: switch (voidingVolumeType) {
                              _VoidingVolumeType.max => '${context.unitValue(diaryVodingSummaryModel.maxVolume)}',
                              _VoidingVolumeType.min => '${context.unitValue(diaryVodingSummaryModel.minVolume)}',
                            },
                            style: context.textStyleTheme.b24Bold.copyWith(color: context.colorTheme.neutral.shade10),
                          ),
                          const TextSpan(text: ' '),
                          TextSpan(text: context.unitName),
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
              final voidingIntervalType = _VoidingIntervalType.values[realIndex];

              return Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      voidingIntervalType.text.tr(context),
                      style: context.textStyleTheme.b14Medium
                          .copyWith(color: context.colorTheme.vermilion.primary.shade50),
                    ),
                    const Gap(8),
                    Text(
                      switch (voidingIntervalType) {
                        _VoidingIntervalType.max => diaryVodingSummaryModel.maxInterval,
                        _VoidingIntervalType.mean => diaryVodingSummaryModel.meanInterval,
                        _VoidingIntervalType.min => diaryVodingSummaryModel.minInterval,
                      },
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
