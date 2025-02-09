import 'dart:math';

import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/extension/string_extension.dart';
import 'package:bradderly/presentation/feature/diary/diary/model/diary_history_model.dart';
import 'package:bradderly/presentation/feature/diary/diary/model/diary_history_type_model.dart';
import 'package:bradderly/presentation/generated/assets/assets.gen.dart';
import 'package:bradderly/presentation/router/route/main_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DiaryHistoriesWidget extends StatelessWidget {
  const DiaryHistoriesWidget({
    super.key,
    required this.diaryHistoryModels,
  });

  final List<DiaryHistoryModel> diaryHistoryModels;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'List'.tr(context),
              style: context.textStyleTheme.b20Bold.copyWith(
                color: context.colorTheme.neutral.shade10,
              ),
            ),
            const Spacer(),
            Row(
              children: List.generate(
                max(DiaryHistoryTypeModel.values.length * 2 - 1, 0),
                (index) {
                  if (index.isOdd) return const Gap(8);

                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12.5, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: context.colorTheme.neutral.shade2,
                    ),
                    child: Text(
                      DiaryHistoryTypeModel.values[index ~/ 2].text.tr(context),
                      style: context.textStyleTheme.b12SemiBold.copyWith(
                        color: DiaryHistoryTypeModel.values[index ~/ 2].getColor(context),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        const Gap(24),
        if (diaryHistoryModels.isEmpty)
          Container(
            height: 138,
            alignment: Alignment.center,
            child: Text(
              'List Na Message'.tr(context),
              style: context.textStyleTheme.b16Medium.copyWith(
                color: context.colorTheme.neutral.shade6,
              ),
              textAlign: TextAlign.center,
            ),
          )
        else
          Column(
            children: [
              Row(
                children: List.generate(
                  _DiaryHistoryColumn.values.length,
                  (index) {
                    final column = _DiaryHistoryColumn.values[index];
                    return Container(
                      alignment: Alignment.center,
                      width: column.getWidth(context),
                      child: Text(
                        column.text.tr(context),
                        style: context.textStyleTheme.b12Medium.copyWith(
                          color: context.colorTheme.neutral.shade6,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Gap(8),
              const Divider(color: Color(0xFFE6E6E6), height: 1),
              for (final diaryHistoryModel in diaryHistoryModels) ...[
                GestureDetector(
                  onTap: () => switch (diaryHistoryModel.type) {
                    DiaryHistoryTypeModel.voiding => ManualInputRoute(historyId: diaryHistoryModel.id).go(context),
                    DiaryHistoryTypeModel.leakage => ManualInputRoute(historyId: diaryHistoryModel.id).go(context),
                    DiaryHistoryTypeModel.intake =>
                      IntakeInputRoute.fromHistoryId(historyId: diaryHistoryModel.id).go(context),
                  },
                  behavior: HitTestBehavior.translucent,
                  child: _HistoryWidget(diaryHistoryModel: diaryHistoryModel),
                ),
                const Divider(color: Color(0xFFE6E6E6), height: 1),
              ],
            ],
          ),
      ],
    );
  }
}

enum _DiaryHistoryColumn {
  time,
  amount,
  urge,
  leak,
  type,
  ;

  String get text {
    return switch (this) {
      time => 'Time',
      amount => 'Amount',
      urge => 'Urge',
      leak => 'Leak',
      type => 'Type',
    };
  }

  double getWidth(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return switch (this) {
      time => width * 0.22,
      amount => width * 0.2,
      urge => width * 0.19,
      leak => width * 0.10,
      type => width * 0.2,
    };
  }
}

class _HistoryWidget extends StatelessWidget {
  const _HistoryWidget({
    required this.diaryHistoryModel,
  });

  final DiaryHistoryModel diaryHistoryModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: List.generate(
          _DiaryHistoryColumn.values.length,
          (index) {
            final column = _DiaryHistoryColumn.values[index];
            return Container(
              alignment: Alignment.center,
              width: column.getWidth(context),
              child: switch (column) {
                _DiaryHistoryColumn.time => Row(
                    children: [
                      Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: diaryHistoryModel.type.getColor(context),
                        ),
                      ),
                      const Gap(4),
                      Text(
                        diaryHistoryModel.getRecordTime(context),
                        style: context.textStyleTheme.b14Medium.copyWith(
                          color: context.colorTheme.neutral.shade10,
                        ),
                      ),
                      const Gap(8),
                      if (diaryHistoryModel.isNocturia)
                        Assets.icon.icDiaryNighttime
                            .svg(colorFilter: ColorFilter.mode(context.colorTheme.neutral.shade6, BlendMode.srcIn)),
                    ],
                  ),
                _DiaryHistoryColumn.amount => Text(
                    diaryHistoryModel.getRecordVolume(context),
                    style: context.textStyleTheme.b14Medium.copyWith(
                      color: diaryHistoryModel.type.getColor(context),
                    ),
                  ),
                _DiaryHistoryColumn.urge => Text(
                    diaryHistoryModel.recordUrgency?.toString() ?? '',
                    style: context.textStyleTheme.b14Medium.copyWith(
                      color: context.colorTheme.neutral.shade8,
                    ),
                  ),
                _DiaryHistoryColumn.leak => Text(
                    diaryHistoryModel.leakageVolume?.tr(context) ?? '',
                    style: context.textStyleTheme.b14Medium.copyWith(
                      color: context.colorTheme.neutral.shade8,
                    ),
                  ),
                _DiaryHistoryColumn.type => Text(
                    diaryHistoryModel.beverageType?.tr(context) ?? '',
                    style: context.textStyleTheme.b14Medium.copyWith(
                      color: context.colorTheme.neutral.shade8,
                    ),
                  ),
              },
            );
          },
        ),
      ),
    );
  }
}
