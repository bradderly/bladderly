// Package imports:
// Project imports:
import 'package:bladderly/domain/model/histories.dart';
import 'package:bladderly/presentation/common/extension/double_extension.dart';
import 'package:bladderly/presentation/common/extension/duration_extension.dart';
import 'package:equatable/equatable.dart';

class DiaryVoidingSummaryModel extends Equatable {
  const DiaryVoidingSummaryModel({
    required this.totalVolume,
    required this.daytimeFrequency,
    required this.nighttimeFrequency,
    required this.leakageFrequency,
    required this.maxVolume,
    required this.minVolume,
    required this.maxInterval,
    required this.meanInterval,
    required this.minInterval,
  });

  const DiaryVoidingSummaryModel.none()
      : totalVolume = 0,
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
      totalVolume: histories.voidings.totalVolume.toRoundVolume(),
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

  final int totalVolume;
  final int daytimeFrequency;
  final int nighttimeFrequency;
  final int leakageFrequency;
  final int maxVolume;
  final int minVolume;
  final String maxInterval;
  final String meanInterval;
  final String minInterval;

  @override
  List<Object?> get props => [
        totalVolume,
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
