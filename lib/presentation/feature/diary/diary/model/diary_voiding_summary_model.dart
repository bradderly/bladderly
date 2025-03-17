// Package imports:
// Project imports:
import 'package:bladderly/domain/model/histories.dart';
import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/double_extension.dart';
import 'package:bladderly/presentation/common/extension/duration_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class DiaryVoidingSummaryModel extends Equatable {
  const DiaryVoidingSummaryModel({
    required List<double> volumes,
    required this.daytimeFrequency,
    required this.nighttimeFrequency,
    required this.leakageFrequency,
    required this.maxVolume,
    required this.minVolume,
    required this.maxInterval,
    required this.meanInterval,
    required this.minInterval,
  }) : _volumes = volumes;

  const DiaryVoidingSummaryModel.none()
      : _volumes = const [],
        daytimeFrequency = 0,
        nighttimeFrequency = 0,
        leakageFrequency = 0,
        maxVolume = 0,
        minVolume = 0,
        maxInterval = '00:00',
        meanInterval = '00:00',
        minInterval = '00:00';

  factory DiaryVoidingSummaryModel.fromDomain(Histories histories) {
    return DiaryVoidingSummaryModel(
      volumes: histories.voidings.map((e) => e.recordVolume).toList(),
      daytimeFrequency: histories.voidings.daytimeFrequency,
      nighttimeFrequency: histories.voidings.nighttimeFrequency,
      leakageFrequency: histories.leakageFrequency,
      maxVolume: histories.voidings.maxVolume.toRoundVolume(),
      minVolume: histories.voidings.minVolume.toRoundVolume(),
      maxInterval: histories.voidings.maxInterval.formatHHMM(),
      minInterval: histories.voidings.minInterval.formatHHMM(),
      meanInterval: histories.voidings.meanInterval.formatHHMM(),
    );
  }

  final List<double> _volumes;
  final int daytimeFrequency;
  final int nighttimeFrequency;
  final int leakageFrequency;
  final int maxVolume;
  final int minVolume;
  final String maxInterval;
  final String meanInterval;
  final String minInterval;

  /// 로컬 DB를 double로 설계해서 int로 파싱 필요
  ///
  ///  실제 데이터는 전부 int값을 저장하고 있어서 int값이 저장되지 않은 테스트 데이터 이외에는 전부 상관이 없음
  int getTotalVolume(BuildContext context) {
    return _volumes.map((e) => e.toInt()).map(context.unitValue).fold<int>(0, (a, b) => a + b);
  }

  @override
  List<Object?> get props => [
        _volumes,
        getTotalVolume,
        daytimeFrequency,
        nighttimeFrequency,
        leakageFrequency,
        maxVolume,
        minVolume,
        maxInterval,
        meanInterval,
        minInterval,
      ];
}
