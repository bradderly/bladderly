import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/extension/string_extension.dart';
import 'package:bradderly/presentation/common/model/beverage_type_model.dart';
import 'package:bradderly/presentation/feature/diary/diary/model/diary_intake_summary_model.dart';
import 'package:bradderly/presentation/generated/assets/assets.gen.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DiaryIntakeSummaryWidget extends StatelessWidget {
  const DiaryIntakeSummaryWidget({
    super.key,
    required this.onExpand,
    required this.isExpanded,
    required this.diaryIntakeSummaryModel,
  });

  final void Function(bool isExpanded) onExpand;
  final bool isExpanded;
  final DiaryIntakeSummaryModel diaryIntakeSummaryModel;

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTotalAmount(context),
                if (isExpanded) ...[
                  _buildDivider(),
                  _buildFrequency(context),
                  const Gap(8),
                  _buildProportion(context),
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
      'Intake'.tr(context),
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
              TextSpan(text: '${diaryIntakeSummaryModel.totalVolume}'),
              const WidgetSpan(child: SizedBox(width: 4)),
              TextSpan(text: context.unitName),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFrequency(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Frequency'.tr(context),
          style: context.textStyleTheme.b16SemiBold.copyWith(
            color: context.colorTheme.neutral.shade10,
          ),
        ),
        const Spacer(),
        RichText(
          text: TextSpan(
            style: context.textStyleTheme.b24Bold.copyWith(color: context.colorTheme.neutral.shade10),
            children: [
              TextSpan(text: '${diaryIntakeSummaryModel.frequency} '),
              TextSpan(
                text: 'times'.tr(context),
                style: context.textStyleTheme.b16Medium,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProportion(BuildContext context) {
    final entries = diaryIntakeSummaryModel.beverageTypeRateMap.entries;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Proportion'.tr(context),
          style: context.textStyleTheme.b16SemiBold.copyWith(
            color: context.colorTheme.neutral.shade10,
          ),
        ),
        const Gap(8),
        Container(
          height: 16,
          decoration: BoxDecoration(
            color: context.colorTheme.neutral.shade4,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: entries
                .mapIndexed(
                  (index, entry) => Expanded(
                    flex: (entry.value * 100).toInt(),
                    child: Container(
                      height: 16,
                      decoration: BoxDecoration(
                        color: entry.key.color,
                        borderRadius: BorderRadius.horizontal(
                          left: index == 0 ? const Radius.circular(10) : Radius.zero,
                          right: index == entries.length - 1 ? const Radius.circular(10) : Radius.zero,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        const Gap(16),
        Column(
          children: List.generate(
            3,
            (index) {
              if (index.isOdd) return const Gap(4);

              final rowIndex = index ~/ 2;

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (index) {
                    if (index.isOdd) return const Gap(8);

                    final columnIndex = index ~/ 2;
                    final beverageType = BeverageTypeModel.values[rowIndex * 3 + columnIndex];

                    return Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: beverageType.color,
                          ),
                        ),
                        const Gap(4),
                        SizedBox(
                          width: columnIndex == 1 ? 62 : 44,
                          child: Text(
                            beverageType.name.tr(context),
                            style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade6),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
