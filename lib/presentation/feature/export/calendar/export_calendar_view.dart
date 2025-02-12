import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/extension/datetime_extension.dart';
import 'package:bradderly/presentation/common/extension/string_extension.dart';
import 'package:bradderly/presentation/common/locale/app_locale.dart';
import 'package:bradderly/presentation/feature/export/calendar/cubit/export_dates_cubit.dart';
import 'package:bradderly/presentation/feature/export/calendar/widget/export_calendar_app_bar.dart';
import 'package:bradderly/presentation/feature/export/widget/export_stickey_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:scrolls_to_top/scrolls_to_top.dart';

enum _DateType {
  selected,
  today,
  outDate,
  normal,
  ;

  factory _DateType.from({
    required bool isToday,
    required bool isSelected,
    required bool isOutDate,
  }) {
    if (isSelected) return _DateType.selected;
    if (isToday) return _DateType.today;
    if (isOutDate) return _DateType.outDate;
    return _DateType.normal;
  }

  Color getColor(BuildContext context) {
    return switch (this) {
      selected => context.colorTheme.neutral.shade9,
      normal => context.colorTheme.neutral.shade9,
      today => context.colorTheme.vermilion.primary.shade40,
      outDate => context.colorTheme.neutral.shade6,
    };
  }

  Color? getBoxColor(BuildContext context) {
    return switch (this) {
      selected => context.colorTheme.vermilion.secondary.shade10,
      _ => null,
    };
  }
}

class ExportCalendarView extends StatefulWidget {
  const ExportCalendarView({
    super.key,
    required this.onTapNext,
    required this.historyDates,
  });

  final void Function(List<DateTime>) onTapNext;

  final List<DateTime> historyDates;

  @override
  State<ExportCalendarView> createState() => _ExportCalendarViewState();
}

class _ExportCalendarViewState extends State<ExportCalendarView> {
  final today = DateUtils.dateOnly(DateTime.now());
  late final scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollsToTop(
      onScrollsToTop: (_) => scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeOutCirc,
      ),
      child: Scaffold(
        appBar: ExportCalendarAppBar(onTapToday: () => scrollController.jumpTo(0)),
        body: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: [
              ListView.builder(
                controller: scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 48),
                itemBuilder: (context, index) {
                  final calendarDate = DateUtils.addMonthsToMonthDate(today, -index);
                  return Column(
                    children: [
                      _buildCalendarHeader(context, calendarDate: calendarDate),
                      const Gap(32),
                      _buildCalendarWeekDay(context),
                      const Gap(24),
                      _buildCalendarDay(context, calendarDate: calendarDate),
                      const Gap(48),
                    ],
                  );
                },
              ),
              Positioned.fill(
                top: null,
                child: BlocSelector<ExportDatesCubit, ExportDatesState, List<DateTime>>(
                  selector: (state) => state.dates,
                  builder: (context, selectedDates) => ExportStickeyButton(
                    onTap: selectedDates.isEmpty ? null : () => widget.onTapNext(selectedDates),
                    text: 'Continue'.tr(context),
                    header: RichText(
                      text: TextSpan(
                        children: [
                          if (selectedDates.isEmpty)
                            TextSpan(text: 'You can export up to 7 days'.tr(context))
                          else ...[
                            TextSpan(text: '${selectedDates.length}'),
                            switch (context.locale) {
                              AppLocale.en when selectedDates.length == 1 => const TextSpan(text: ' day selected '),
                              AppLocale.en => const TextSpan(text: ' days selected '),
                              AppLocale.ko => const TextSpan(text: '일 선택됨 '),
                            },
                            TextSpan(
                              text: '(up to 7 days)'.tr(context),
                              style: selectedDates.length == 7 ? TextStyle(color: context.colorTheme.warning) : null,
                            ),
                          ],
                        ],
                        style: context.textStyleTheme.b16SemiBold.copyWith(
                          color: context.colorTheme.neutral.shade6,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarHeader(
    BuildContext context, {
    required DateTime calendarDate,
  }) {
    return Column(
      children: [
        Text(
          calendarDate.getMonthTr(context),
          style: context.textStyleTheme.b20Bold.copyWith(
            color: context.colorTheme.neutral.shade10,
          ),
        ),
        Text(
          '${calendarDate.year}',
          style: context.textStyleTheme.b14SemiBold.copyWith(
            color: context.colorTheme.neutral.shade10,
          ),
        ),
      ],
    );
  }

  Row _buildCalendarWeekDay(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        7,
        (index) => Container(
          width: 38,
          alignment: Alignment.center,
          child: Text(
            context.locale.getDayOfWeek(index == 0 ? 6 : index - 1),
            style: context.textStyleTheme.b14Medium
                .copyWith(color: index == 0 ? context.colorTheme.warning : context.colorTheme.neutral.shade6),
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarDay(
    BuildContext context, {
    required DateTime calendarDate,
  }) {
    return BlocSelector<ExportDatesCubit, ExportDatesState, List<DateTime>>(
      selector: (state) => state.dates,
      builder: (context, selectedDates) {
        final firstDayOfMonth = DateTime(calendarDate.year, calendarDate.month);
        final firstDayOffsetOfMonth = firstDayOfMonth.weekday == DateTime.sunday ? 0 : firstDayOfMonth.weekday;

        return Column(
          children: List.generate(
            9,
            (index) {
              if (index.isOdd) return const Gap(20);

              final rowIndex = index ~/ 2;

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(7, (columnIndex) {
                  final date = firstDayOfMonth.add(Duration(days: rowIndex * 7 + columnIndex - firstDayOffsetOfMonth));
                  final isNotSameMonth = !DateUtils.isSameMonth(date, calendarDate);
                  final isOutDate = date.isAfter(today) || !DateUtils.isSameMonth(date, calendarDate);
                  final containsHistory = widget.historyDates.contains(date);

                  final dateType = _DateType.from(
                    isToday: DateUtils.isSameDay(date, today),
                    isSelected: selectedDates.contains(date),
                    isOutDate: isOutDate,
                  );

                  return GestureDetector(
                    onTap: () {
                      if (isOutDate || !containsHistory) return;

                      context.read<ExportDatesCubit>().select(date);
                    },
                    child: Container(
                      width: 38,
                      height: 38,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: dateType.getBoxColor(context),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: isNotSameMonth
                          ? null
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 17,
                                  child: Text(
                                    '${date.day}',
                                    style: context.textStyleTheme.b16Medium.copyWith(
                                      color: dateType.getColor(context),
                                    ),
                                  ),
                                ),
                                const Gap(5),
                                Container(
                                  width: 4,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: widget.historyDates.contains(date)
                                        ? context.colorTheme.vermilion.primary.shade50
                                        : null,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  );
                }),
              );
            },
          ),
        );
      },
    );
  }
}
