import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/extension/string_extension.dart';
import 'package:bradderly/presentation/generated/assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DiaryVoidingSummaryWidget extends StatefulWidget {
  const DiaryVoidingSummaryWidget({super.key});

  @override
  State<DiaryVoidingSummaryWidget> createState() => _DiaryVoidingSummaryWidgetState();
}

class _DiaryVoidingSummaryWidgetState extends State<DiaryVoidingSummaryWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
              const Gap(16),
              const Divider(color: Color(0xFFE6E6E6)),
              const Gap(16),
              _buildFrequency(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Text(
      'Voiding'.tr,
      style: context.textStyleTheme.b16SemiBold.copyWith(
        color: context.colorTheme.vermilion.primary.shade50,
      ),
    );
  }

  Widget _buildTotalAmount(BuildContext context) {
    return Row(
      children: [
        Text(
          'Total amount'.tr,
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
              const WidgetSpan(child: Gap(4)),
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
          'Frequency'.tr,
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
              final texts = ['Daytime', 'Nighttime', 'Leakage'];

              return Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        icons[realIndex].svg(),
                        Text(
                          texts[realIndex].tr,
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
                            TextSpan(text: 'times'.tr),
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
}
