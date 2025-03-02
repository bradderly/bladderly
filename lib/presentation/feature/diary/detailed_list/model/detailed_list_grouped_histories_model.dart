// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:bladderly/domain/model/histories.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/feature/diary/detailed_list/model/detailed_list_history_model.dart';

class DetailedListGroupedHistoriesModel extends Equatable {
  const DetailedListGroupedHistoriesModel._({
    required this.groupedHistories,
    required List<Duration> intervals,
  }) : _intervals = intervals;

  factory DetailedListGroupedHistoriesModel.fromHistoies(Histories histories) {
    final groupedHistories = histories
        .groupByRecordTime()
        .map((key, value) => MapEntry(key, value.map(DetailedListHistoryModel.fromHistory).toList()));

    final intervals = [
      for (int i = 0; i < groupedHistories.keys.length - 1; i++)
        groupedHistories.keys.elementAt(i + 1).difference(groupedHistories.keys.elementAt(i)),
    ];

    return DetailedListGroupedHistoriesModel._(
      groupedHistories: groupedHistories,
      intervals: intervals,
    );
  }

  const DetailedListGroupedHistoriesModel.empty()
      : groupedHistories = const {},
        _intervals = const [];

  final Map<DateTime, List<DetailedListHistoryModel>> groupedHistories;
  final List<Duration> _intervals;

  int get keyCount => groupedHistories.keys.length;

  String getInterval(BuildContext context, {required int index}) {
    final interval = _intervals.elementAt(index);

    return switch (interval.inMinutes) {
      < 60 => '${interval.inMinutes} ${'minutes'.tr(context)}',
      == 60 => '1 ${'hour'.tr(context)}',
      _ => '${interval.inHours} ${'hours'.tr(context)} ${interval.inMinutes.remainder(60)} ${'minutes'.tr(context)}',
    };
  }

  ({int groupIndex, int itemIndex})? getIndexById(int id) {
    for (var i = 0; i < groupedHistories.keys.length; i++) {
      final key = groupedHistories.keys.elementAt(i);
      if (groupedHistories[key]?.indexWhere((element) => element.id == id) case final int index when index != -1) {
        return (groupIndex: i, itemIndex: index);
      }
    }

    return null;
  }

  bool get isEmpty => groupedHistories.isEmpty;

  bool get isNotEmpty => groupedHistories.isNotEmpty;

  List<int> get historyIds => groupedHistories.values.flattenedToList.map((e) => e.id).toList();

  @override
  List<Object> get props => [
        groupedHistories,
      ];
}
