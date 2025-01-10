import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/extension/string_extension.dart';
import 'package:bradderly/presentation/feature/diary/diary/widget/diary_voiding_summary_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DiaryTodaySummaryWidget extends StatelessWidget {
  const DiaryTodaySummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Today Summary'.tr,
          style: context.textStyleTheme.b20Bold.copyWith(
            color: context.colorTheme.neutral.shade10,
          ),
        ),
        const Gap(24),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          decoration: BoxDecoration(
            boxShadow: context.shadowTheme.shadow3,
            color: context.colorTheme.neutral.shade2,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              DiaryVoidingSummaryWidget(),
            ],
          ),
        ),
      ],
    );
  }
}
