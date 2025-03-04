// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/datetime_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';

enum _DiaryCalendarModalType {
  calendar,
  month,
}

class DiaryCalendarBottomSheet extends StatefulWidget {
  const DiaryCalendarBottomSheet._({
    required this.minDate,
    required this.maxDate,
    required this.today,
    required this.selectedDate,
    required this.highlightedDates,
  });

  final DateTime minDate;
  final DateTime maxDate;
  final DateTime today;
  final DateTime selectedDate;
  final List<DateTime> highlightedDates;

  static Future<DateTime?> show(
    BuildContext context, {
    required DateTime minDate,
    required DateTime maxDate,
    required DateTime today,
    required DateTime selectedDate,
    required List<DateTime> highlightedDates,
  }) {
    return showModalBottomSheet<DateTime>(
      context: context,
      isScrollControlled: true,
      builder: (context) => DiaryCalendarBottomSheet._(
        minDate: minDate,
        maxDate: maxDate,
        today: today,
        selectedDate: selectedDate,
        highlightedDates: highlightedDates,
      ),
    );
  }

  @override
  State<DiaryCalendarBottomSheet> createState() => _DiaryCalendarBottomSheetState();
}

class _DiaryCalendarBottomSheetState extends State<DiaryCalendarBottomSheet> {
  late final minCalendarDate = DateTime(widget.minDate.year, widget.minDate.month);
  late final maxCalendarDate = DateTime(widget.maxDate.year, widget.maxDate.month);

  late DateTime calendarDate = DateTime(widget.selectedDate.year, widget.selectedDate.month);
  late DateTime selectedDate = widget.selectedDate;

  _DiaryCalendarModalType _diaryCalendarModalType = _DiaryCalendarModalType.calendar;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
          child: Column(
            children: [
              _buildHeader(context),
              const Gap(40),
              switch (_diaryCalendarModalType) {
                _DiaryCalendarModalType.calendar => _buildCalendar(context),
                _DiaryCalendarModalType.month => _buildMonths(context),
              },
            ],
          ),
        ),
        Divider(height: 1, thickness: 1, color: context.colorTheme.neutral.shade5),
        Padding(
          padding: const EdgeInsets.only(top: 16, left: 16, bottom: 24, right: 22),
          child: IntrinsicHeight(
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => setState(
                    () {
                      calendarDate = DateTime(widget.today.year, widget.today.month);
                      selectedDate = widget.today;
                    },
                  ),
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    alignment: Alignment.center,
                    width: 90,
                    child: Text(
                      'Today'.tr(context),
                      style: context.textStyleTheme.b16SemiBold.copyWith(
                        color: context.colorTheme.vermilion.primary.shade50,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Builder(
                  builder: (context) {
                    final isDisabled = switch (_diaryCalendarModalType) {
                      _DiaryCalendarModalType.calendar => false,
                      _DiaryCalendarModalType.month => true,
                    };

                    return GestureDetector(
                      onTap: isDisabled ? null : () => context.pop<DateTime>(selectedDate),
                      behavior: HitTestBehavior.translucent,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(
                          color: isDisabled
                              ? context.colorTheme.neutral.shade5
                              : context.colorTheme.vermilion.primary.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Done'.tr(context),
                          style: context.textStyleTheme.b16SemiBold.copyWith(
                            color: context.colorTheme.neutral.shade0,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => setState(
            () => _diaryCalendarModalType = switch (_diaryCalendarModalType) {
              _DiaryCalendarModalType.month => _DiaryCalendarModalType.calendar,
              _DiaryCalendarModalType.calendar => _DiaryCalendarModalType.month,
            },
          ),
          behavior: HitTestBehavior.translucent,
          child: Row(
            children: [
              Text(
                calendarDate.getCalendarHeader(context),
                style: context.textStyleTheme.b18SemiBold.copyWith(color: context.colorTheme.neutral.shade10),
              ),
              const Gap(8),
              RotatedBox(
                quarterTurns: switch (_diaryCalendarModalType) {
                  _DiaryCalendarModalType.month => 1,
                  _DiaryCalendarModalType.calendar => 0,
                },
                child: Assets.icon.icDiaryRightArrowSmall.svg(),
              ),
            ],
          ),
        ),
        const Spacer(),
        if (calendarDate.isAfter(minCalendarDate))
          GestureDetector(
            onTap: () => setState(() => calendarDate = DateUtils.addMonthsToMonthDate(calendarDate, -1)),
            behavior: HitTestBehavior.translucent,
            child: Assets.icon.icDiaryLeftArrow.svg(),
          ),
        if (calendarDate.isAfter(minCalendarDate) && calendarDate.isBefore(maxCalendarDate)) const Gap(16),
        if (calendarDate.isBefore(maxCalendarDate))
          GestureDetector(
            onTap: () => setState(() => calendarDate = DateUtils.addMonthsToMonthDate(calendarDate, 1)),
            behavior: HitTestBehavior.translucent,
            child: Assets.icon.icDiaryRightArrow.svg(),
          ),
      ],
    );
  }

  Widget _buildCalendar(BuildContext context) {
    final firstWeekDayOfMonth = calendarDate.weekday == 7 ? 0 : calendarDate.weekday;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            7,
            (index) => Container(
              alignment: Alignment.center,
              width: 38,
              child: Text(
                context.locale.getDayOfWeek(index == 0 ? 6 : index - 1),
                style: context.textStyleTheme.b14SemiBold.copyWith(
                  color: index == 0 ? context.colorTheme.warning : context.colorTheme.neutral.shade6,
                ),
              ),
            ),
          ),
        ),
        const Gap(24),
        ...List.generate(
          11,
          (index) {
            if (index.isOdd) return const Gap(18);

            final rowIndex = index ~/ 2;

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                7,
                (columnIndex) {
                  final cellIndex = rowIndex * 7 + columnIndex;

                  final date = calendarDate.add(Duration(days: cellIndex - firstWeekDayOfMonth));
                  final isSameMonth = DateUtils.isSameMonth(date, calendarDate);
                  final isSelectable = date.isBetween(widget.minDate, widget.maxDate);
                  final isSelected = date == selectedDate;
                  final isToday = date == widget.today;

                  return GestureDetector(
                    onTap: isSelectable ? () => setState(() => selectedDate = date) : null,
                    child: Container(
                      padding: const EdgeInsets.only(top: 8),
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: isSelected ? context.colorTheme.vermilion.primary.shade50 : null,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '${date.day}',
                            style: context.textStyleTheme.b16Medium.copyWith(
                              color: switch (null) {
                                _ when isSelected => context.colorTheme.neutral.shade0,
                                _ when !isSelectable || !isSameMonth => context.colorTheme.neutral.shade6,
                                _ when isToday => context.colorTheme.vermilion.primary.shade50,
                                _ => context.colorTheme.neutral.shade10,
                              },
                            ),
                          ),
                          if (widget.highlightedDates.contains(date)) ...[
                            const Gap(2.5),
                            Container(
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected
                                    ? context.colorTheme.neutral.shade0
                                    : context.colorTheme.vermilion.primary.shade50,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildMonths(BuildContext context) {
    const rowCount = 4;
    const columnCount = 3;

    final selectedMonth = calendarDate.month;

    return Column(
      children: List.generate(
        rowCount * 2 - 1,
        (index) {
          if (index.isOdd) return const Gap(16);

          final rowIndex = index ~/ 2;

          return Row(
            children: List.generate(
              columnCount * 2 - 1,
              (index) {
                if (index.isOdd) return const Gap(16);

                final columnIndex = index ~/ 2;
                final cellIndex = rowIndex * columnCount + columnIndex;
                final month = cellIndex + 1;
                final isSelectedMonth = month == selectedMonth;
                final date = DateTime(calendarDate.year, month);
                final isTodayMonth = DateUtils.isSameMonth(widget.today, date);
                final isSelectable = date.isBetween(minCalendarDate, maxCalendarDate);

                return Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) => GestureDetector(
                      onTap: isSelectable ? () => setState(() => calendarDate = date) : null,
                      behavior: HitTestBehavior.translucent,
                      child: Container(
                        alignment: Alignment.center,
                        height: constraints.maxWidth * 60 / 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: isSelectedMonth ? context.colorTheme.vermilion.primary.shade50 : null,
                        ),
                        child: Text(
                          context.locale.getMonth(cellIndex).tr(context),
                          style: context.textStyleTheme.b16Medium.copyWith(
                            color: switch (null) {
                              _ when isSelectedMonth => context.colorTheme.neutral.shade0,
                              _ when isTodayMonth => context.colorTheme.vermilion.primary.shade50,
                              _ => context.colorTheme.neutral.shade6,
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
