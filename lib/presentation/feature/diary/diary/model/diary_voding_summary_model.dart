// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:bladderly/domain/model/histories.dart';
import 'package:bladderly/presentation/common/extension/duration_extension.dart';

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

  factory DiaryVoidingSummaryModel.fromDomain(VodingHistories vodingHistories) {
    return DiaryVoidingSummaryModel(
      totalVolume: vodingHistories.totalVolume,
      daytimeFrequency: vodingHistories.daytimeFrequency,
      nighttimeFrequency: vodingHistories.nighttimeFrequency,
      leakageFrequency: vodingHistories.leakageFrequency,
      maxVolume: vodingHistories.maxVolume,
      minVolume: vodingHistories.minVolume,
      maxInterval: vodingHistories.maxInterval.formatHHMM(),
      minInterval: vodingHistories.minInterval.formatHHMM(),
      meanInterval: vodingHistories.meanInterval.formatHHMM(),
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
