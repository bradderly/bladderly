// Dart imports:
import 'dart:math' as math;

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

// Project imports:
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/datetime_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/feature/diary/diary/cubit/diary_history_dates_cubit.dart';
import 'package:bladderly/presentation/feature/diary/diary/modal/diary_calendar_modal.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';

class DiaryAppBar extends StatefulWidget implements PreferredSizeWidget {
  const DiaryAppBar({
    super.key,
    required this.onTapExport,
    required this.onChanged,
    required this.today,
  });

  final VoidCallback onTapExport;
  final void Function(DateTime) onChanged;
  final DateTime today;

  @override
  State<DiaryAppBar> createState() => _DiaryAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(170);
}

class _DiaryAppBarState extends State<DiaryAppBar> {
  final minDate = DateTime(2022).subtract(const Duration(days: 3));

  late final itemExtent = MediaQuery.sizeOf(context).width / 7;
  late final scrollController = ScrollController();

  late DateTime maxDate = widget.today.add(const Duration(days: 3));

  late DateTime selectedDate = widget.today;

  @override
  void didUpdateWidget(covariant DiaryAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    final dayDiff = widget.today.difference(oldWidget.today).inDays;
    if (dayDiff != 0) {
      setState(() => maxDate = widget.today.add(const Duration(days: 3)));
      scrollController.jumpTo(scrollController.offset + dayDiff * itemExtent);
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void onTap({
    required int index,
    required DateTime date,
  }) {
    if (date.isAfter(widget.today)) return;
    scrollToIndex(index);
  }

  void scrollToIndex(int index, {bool jumpTo = false}) {
    final offset = (index - 3) * itemExtent;

    if (jumpTo) {
      scrollController.jumpTo(offset);
    } else {
      scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> onTapCalendar() async {
    final dateTime = await DiaryCalendarBottomSheet.show(
      context,
      minDate: minDate.add(const Duration(days: 3)),
      maxDate: maxDate.subtract(const Duration(days: 3)),
      today: widget.today,
      selectedDate: selectedDate,
      highlightedDates: context.read<DiaryHistoryDatesCubit>().state.dates,
    );

    if (dateTime == null) return;

    scrollToIndex(maxDate.difference(dateTime).inDays, jumpTo: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: ColoredBox(
        color: context.colorTheme.neutral.shade0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: onTapCalendar,
                        child: Assets.icon.icDiaryCalendar.svg(),
                      ),
                      const Gap(8),
                      Builder(
                        builder: (context) {
                          final isTodaySelected = widget.today == selectedDate;
                          final color = isTodaySelected
                              ? context.colorTheme.vermilion.secondary.shade30
                              : context.colorTheme.neutral.shade5;

                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: color,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Text(
                              'Today'.tr(context),
                              style: context.textStyleTheme.b16SemiBold.copyWith(color: color),
                            ),
                          );
                        },
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: widget.onTapExport,
                        child: Assets.icon.icDiaryExport.svg(),
                      ),
                    ],
                  ),
                  const Gap(8),
                  Text(
                    selectedDate.getCalendarHeader(context),
                    style: context.textStyleTheme.b20Bold.copyWith(
                      color: context.colorTheme.neutral.shade10,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              height: 64,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Center(
                    child: Container(
                      width: 50,
                      decoration: BoxDecoration(
                        color: context.colorTheme.neutral.shade3,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      if (notification is ScrollEndNotification) {
                        final index = (scrollController.offset / itemExtent).round();
                        final date = maxDate.subtract(Duration(days: index + 3));

                        if (selectedDate != date) {
                          setState(() => selectedDate = date);
                          widget.onChanged(date);
                        }
                      }

                      return true;
                    },
                    child: ListView.builder(
                      physics: _SnapScrollPhysics(itemWidth: itemExtent),
                      controller: scrollController,
                      reverse: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: maxDate.difference(minDate).inDays + 1,
                      itemBuilder: (context, index) {
                        final date = maxDate.subtract(Duration(days: index));

                        final isOutdated = date.isBefore(minDate.add(const Duration(days: 3))) ||
                            date.isAfter(maxDate.subtract(const Duration(days: 3)));

                        return _buildDay(isOutdated, index, date, context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDay(bool isOutdated, int index, DateTime date, BuildContext context) {
    return GestureDetector(
      key: ValueKey(date),
      onTap: isOutdated ? null : () => onTap(index: index, date: date),
      child: Container(
        width: itemExtent,
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned.fill(
              top: 9,
              bottom: null,
              child: Column(
                children: [
                  Text(
                    '${date.day}',
                    style: context.textStyleTheme.b18Bold.copyWith(
                      color: isOutdated ? context.colorTheme.neutral.shade6 : context.colorTheme.neutral.shade10,
                    ),
                  ),
                  const Gap(2),
                  Text(
                    date.getDayOfweek(context),
                    style: context.textStyleTheme.b12Medium.copyWith(
                      color: isOutdated ? context.colorTheme.neutral.shade6 : context.colorTheme.neutral.shade10,
                    ),
                  ),
                ],
              ),
            ),
            Builder(
              builder: (context) {
                final hasHistory =
                    context.select<DiaryHistoryDatesCubit, bool>((cubit) => cubit.state.hasHistory(date));

                if (!hasHistory) return const SizedBox.shrink();

                return Positioned.fill(
                  top: null,
                  bottom: 7,
                  child: Center(
                    child: Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: context.colorTheme.vermilion.primary.shade50,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SnapScrollPhysics extends ScrollPhysics {
  const _SnapScrollPhysics({
    required this.itemWidth,
    super.parent,
  });

  final double itemWidth;

  @override
  _SnapScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return _SnapScrollPhysics(
      itemWidth: itemWidth,
      parent: buildParent(ancestor),
    );
  }

  @override
  Simulation? createBallisticSimulation(ScrollMetrics position, double velocity) {
    final index = (position.pixels / itemWidth).round();

    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
        (velocity >= 0.0 && position.pixels >= position.maxScrollExtent)) {
      return super.createBallisticSimulation(position, velocity);
    }

    final testFrictionSimulation = super.createBallisticSimulation(position, velocity);

    if (testFrictionSimulation != null &&
        (testFrictionSimulation.x(double.infinity) == position.minScrollExtent ||
            testFrictionSimulation.x(double.infinity) == position.maxScrollExtent)) {
      return super.createBallisticSimulation(position, velocity);
    }

    final settlingItemIndex = _getItemFromOffset(
      offset: testFrictionSimulation?.x(double.infinity) ?? position.pixels,
      itemExtent: itemWidth,
      minScrollExtent: position.minScrollExtent,
      maxScrollExtent: position.maxScrollExtent,
    );

    final settlingPixels = settlingItemIndex * itemWidth;

    if (velocity.abs() < toleranceFor(position).velocity &&
        (settlingPixels - position.pixels).abs() < toleranceFor(position).distance) {
      return null;
    }

    if (settlingItemIndex == index) {
      return SpringSimulation(
        spring,
        position.pixels,
        settlingPixels,
        velocity,
        tolerance: toleranceFor(position),
      );
    }

    return FrictionSimulation.through(
      position.pixels,
      settlingPixels,
      velocity,
      toleranceFor(position).velocity * velocity.sign,
    );
  }

  int _getItemFromOffset({
    required double offset,
    required double itemExtent,
    required double minScrollExtent,
    required double maxScrollExtent,
  }) {
    return (_clipOffsetToScrollableRange(offset, minScrollExtent, maxScrollExtent) / itemExtent).round();
  }

  double _clipOffsetToScrollableRange(
    double offset,
    double minScrollExtent,
    double maxScrollExtent,
  ) {
    return math.min(math.max(offset, minScrollExtent), maxScrollExtent);
  }
}
