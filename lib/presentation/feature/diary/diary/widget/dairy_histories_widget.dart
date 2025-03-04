// Dart imports:
import 'dart:math';

// Project imports:
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/feature/diary/diary/model/diary_history_model.dart';
import 'package:bladderly/presentation/feature/diary/diary/model/diary_history_status_model.dart';
import 'package:bladderly/presentation/feature/diary/diary/model/diary_history_type_model.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';
// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:gap/gap.dart';

class DiaryHistoriesWidget extends StatelessWidget {
  const DiaryHistoriesWidget({
    super.key,
    required this.onTapHistory,
    required this.diaryHistoryModels,
  });

  final void Function(DiaryHistoryModel) onTapHistory;
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
        if (diaryHistoryModels.isEmpty) _buildEmptyHistories(context) else _buildHistories(context),
      ],
    );
  }

  Widget _buildHistories(BuildContext context) {
    return Column(
      children: [
        Semantics(
          label: 'Header of List',
          child: Row(
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
        ),
        const Gap(8),
        const Divider(color: Color(0xFFE6E6E6), height: 1),
        for (final diaryHistoryModel in diaryHistoryModels) ...[
          GestureDetector(
            onTap: () => onTapHistory(diaryHistoryModel),
            behavior: HitTestBehavior.translucent,
            child: _HistoryWidget(
              diaryHistoryModel: diaryHistoryModel,
            ),
          ),
          const Divider(color: Color(0xFFE6E6E6), height: 1),
        ],
      ],
    );
  }

  Widget _buildEmptyHistories(BuildContext context) {
    return Container(
      height: 138,
      alignment: Alignment.center,
      child: Text(
        'List Na Message'.tr(context),
        style: context.textStyleTheme.b16Medium.copyWith(
          color: context.colorTheme.neutral.shade6,
        ),
        textAlign: TextAlign.center,
      ),
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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: switch (diaryHistoryModel.status) {
        DiaryHistoryStatusModel.processing => context.colorTheme.vermilion.secondary.shade5,
        DiaryHistoryStatusModel.failed => context.colorTheme.vermilion.secondary.shade5,
        DiaryHistoryStatusModel.done => null,
      },
      child: switch (diaryHistoryModel.status) {
        DiaryHistoryStatusModel.processing => _buildProcessingRow(context),
        DiaryHistoryStatusModel.failed => _buildFailedRow(context),
        DiaryHistoryStatusModel.done => _buildDefaultRow(context),
      },
    );
  }

  Widget _buildTimeColumn(BuildContext context) {
    return Row(
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
    );
  }

  Widget _buildProcessingRow(BuildContext context) {
    return Row(
      children: [
        _buildTimeColumn(context),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.icon.icDiaryUploadProgress.svg(),
              const Gap(4),
              Text(
                'Pending Message'.tr(context),
                style: context.textStyleTheme.b12SemiBold.copyWith(
                  color: context.colorTheme.vermilion.primary.shade50,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFailedRow(BuildContext context) {
    return Row(
      children: [
        _buildTimeColumn(context),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.icon.icDiaryRefresh.svg(),
              const Gap(4),
              Text(
                'Refresh'.tr(context),
                style: context.textStyleTheme.b12SemiBold.copyWith(
                  color: context.colorTheme.vermilion.primary.shade50,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDefaultRow(BuildContext context) {
    return Row(
      children: List.generate(
        _DiaryHistoryColumn.values.length,
        (index) {
          final column = _DiaryHistoryColumn.values[index];

          return Container(
            alignment: Alignment.center,
            width: column.getWidth(context),
            child: switch (column) {
              _DiaryHistoryColumn.time => _buildTimeColumn(context),
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
    );
  }
}
