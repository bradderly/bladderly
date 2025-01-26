import 'dart:math';

import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/extension/string_extension.dart';
import 'package:bradderly/presentation/feature/main/diary/model/diary_history_model.dart';
import 'package:bradderly/presentation/feature/main/diary/model/diary_history_type_model.dart';
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
              for (final diaryHistoryModel in diaryHistoryModels)
                Row(
                  children: List.generate(
                    _DiaryHistoryColumn.values.length,
                    (index) {
                      final column = _DiaryHistoryColumn.values[index];
                      return Container(
                        alignment: Alignment.center,
                        width: column.getWidth(context),
                        child: Text(
                          switch (column) {
                            _DiaryHistoryColumn.time => diaryHistoryModel.recordTime,
                            _DiaryHistoryColumn.amount => diaryHistoryModel.recordVolume == null
                                ? 'N/A'
                                : '${context.unitValue(diaryHistoryModel.recordVolume!)}${context.unit.tr(context)}',
                            _DiaryHistoryColumn.urge => diaryHistoryModel.recordUrgency?.toString() ?? '',
                            _DiaryHistoryColumn.leak => diaryHistoryModel.leakageVolume?.tr(context) ?? '',
                            _DiaryHistoryColumn.type => diaryHistoryModel.beverageType?.tr(context) ?? '',
                          },
                          style: context.textStyleTheme.b14Medium.copyWith(
                            color: switch (column) {
                              _DiaryHistoryColumn.time => context.colorTheme.neutral.shade10,
                              _DiaryHistoryColumn.amount => diaryHistoryModel.type.getColor(context),
                              _DiaryHistoryColumn.urge => context.colorTheme.neutral.shade8,
                              _DiaryHistoryColumn.leak => context.colorTheme.neutral.shade8,
                              _DiaryHistoryColumn.type => context.colorTheme.neutral.shade8,
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
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
