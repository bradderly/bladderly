import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/extension/string_extension.dart';
import 'package:bradderly/presentation/feature/main/diary/model/diary_intake_summary_model.dart';
import 'package:bradderly/presentation/feature/main/diary/model/diary_voding_summary_model.dart';
import 'package:bradderly/presentation/feature/main/diary/widget/diary_intake_summary_widget.dart';
import 'package:bradderly/presentation/feature/main/diary/widget/diary_voiding_summary_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DiaryTodaySummaryWidget extends StatelessWidget {
  const DiaryTodaySummaryWidget({
    super.key,
    required this.voidingSummaryKey,
    required this.voidingSummaryExpandController,
    required this.diaryVoidingSummaryModel,
    required this.intakeSummaryKey,
    required this.intakeSummaryExpandController,
    required this.diaryIntakeSummaryModel,
  });

  final Key voidingSummaryKey;
  final ValueNotifier<bool> voidingSummaryExpandController;
  final DiaryVoidingSummaryModel diaryVoidingSummaryModel;

  final Key intakeSummaryKey;
  final ValueNotifier<bool> intakeSummaryExpandController;
  final DiaryIntakeSummaryModel diaryIntakeSummaryModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Summary'.tr,
          style: context.textStyleTheme.b20Bold.copyWith(
            color: context.colorTheme.neutral.shade10,
          ),
        ),
        const Gap(24),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            boxShadow: context.shadowTheme.shadow3,
            color: context.colorTheme.neutral.shade2,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              ListenableBuilder(
                listenable: voidingSummaryExpandController,
                builder: (_, __) => DiaryVoidingSummaryWidget(
                  key: voidingSummaryKey,
                  onExpand: (isExpanded) => voidingSummaryExpandController.value = isExpanded,
                  isExpanded: voidingSummaryExpandController.value,
                  diaryVodingSummaryModel: diaryVoidingSummaryModel,
                ),
              ),
              const Gap(16),
              ListenableBuilder(
                listenable: intakeSummaryExpandController,
                builder: (_, __) => DiaryIntakeSummaryWidget(
                  key: intakeSummaryKey,
                  onExpand: (isExpanded) => intakeSummaryExpandController.value = isExpanded,
                  isExpanded: intakeSummaryExpandController.value,
                  diaryIntakeSummaryModel: diaryIntakeSummaryModel,
                ),
              ),
              const Gap(8),
            ],
          ),
        ),
      ],
    );
  }
}
