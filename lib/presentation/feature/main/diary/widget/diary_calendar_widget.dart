import 'dart:math' as math;

import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/extension/datetime_extension.dart';
import 'package:bradderly/presentation/feature/main/diary/cubit/diary_history_dates_cubit.dart';
import 'package:bradderly/presentation/generated/assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class DiaryCalendarWidget extends StatefulWidget implements PreferredSizeWidget {
  const DiaryCalendarWidget({
    super.key,
    required this.onChanged,
    required this.today,
  });

  final void Function(DateTime) onChanged;
  final DateTime today;

  @override
  State<DiaryCalendarWidget> createState() => _DiaryCalendarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(170);
}

class _DiaryCalendarWidgetState extends State<DiaryCalendarWidget> {
  late final scrollController = ScrollController();

  late DateTime maxDate = widget.today.add(const Duration(days: 3));

  late DateTime selectedDate = widget.today;

  @override
  void didUpdateWidget(covariant DiaryCalendarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    final dayDiff = widget.today.difference(oldWidget.today).inDays;
    if (dayDiff != 0) {
      setState(() => maxDate = widget.today.add(const Duration(days: 3)));
      scrollController.jumpTo(scrollController.offset + dayDiff * 50);
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

    final offset = (index - 3) * 50.0;

    if (offset >= 0) {
      scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colorTheme.neutral.shade0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Assets.icon.icDialryCalendar.svg(),
                const Gap(8),
                Text(
                  selectedDate.calendarHeader,
                  style: context.textStyleTheme.b20Bold.copyWith(
                    color: context.colorTheme.neutral.shade10,
                  ),
                ),
                const Spacer(),
                Assets.icon.icDiaryExport.svg(),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 24),
            height: 64,
            padding: EdgeInsets.symmetric(horizontal: (MediaQuery.sizeOf(context).width - 350) / 2),
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
                      final index = (scrollController.offset / 50).round();
                      final date = maxDate.subtract(Duration(days: index + 3));
                      setState(() => selectedDate = date);
                      widget.onChanged(date);
                    }

                    return true;
                  },
                  child: ListView.builder(
                    controller: scrollController,
                    physics: const _SnapScrollPhysics(itemWidth: 50),
                    reverse: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final date = maxDate.subtract(Duration(days: index));
                      final isOutdated = date.isAfter(widget.today);

                      return _buildDay(isOutdated, index, date, context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDay(bool isOutdated, int index, DateTime date, BuildContext context) {
    return GestureDetector(
      key: ValueKey(date),
      onTap: isOutdated ? null : () => onTap(index: index, date: date),
      child: Container(
        width: 50,
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
                    date.dayOfweek,
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
