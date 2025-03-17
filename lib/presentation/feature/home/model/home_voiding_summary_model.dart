// Package imports:
// Project imports:
import 'package:bladderly/domain/model/histories.dart';
import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/duration_extension.dart';
import 'package:bladderly/presentation/common/extension/num_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class HomeVoidingSummaryModel extends Equatable {
  const HomeVoidingSummaryModel({
    required List<int> volumes,
    required this.frequency,
    required this.lastRecord,
  }) : _volumes = volumes;

  const HomeVoidingSummaryModel.none()
      : _volumes = const [],
        frequency = 0,
        lastRecord = 'N/A';

  factory HomeVoidingSummaryModel.fromDomain(VodingHistories vodingHistories) {
    return HomeVoidingSummaryModel(
      frequency: vodingHistories.length,
      volumes: vodingHistories.map((e) => e.recordVolume.toRoundVolume()).toList(),
      lastRecord: switch (vodingHistories.lastRecordTime) {
        final DateTime lastRecordTime => DateTime.now().difference(lastRecordTime).formatHHMM(),
        _ => 'N/A',
      },
    );
  }

  final List<int> _volumes;
  final int frequency;
  final String lastRecord;

  int getTotalVolume(BuildContext context) {
    return _volumes.map(context.unitValue).fold<int>(0, (a, b) => a + b);
  }

  @override
  List<Object> get props => [
        _volumes,
        frequency,
        lastRecord,
      ];
}
