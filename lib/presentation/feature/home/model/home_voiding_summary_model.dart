import 'package:bradderly/domain/model/histories.dart';
import 'package:bradderly/presentation/common/extension/duration_extension.dart';
import 'package:equatable/equatable.dart';

class HomeVoidingSummaryModel extends Equatable {
  const HomeVoidingSummaryModel({
    required this.frequency,
    required this.totalVoid,
    required this.lastRecord,
  });

  const HomeVoidingSummaryModel.none()
      : frequency = 0,
        totalVoid = 0,
        lastRecord = 'N/A';

  factory HomeVoidingSummaryModel.fromDomain(VodingHistories vodingHistories) {
    return HomeVoidingSummaryModel(
      frequency: vodingHistories.length,
      totalVoid: vodingHistories.totalVolume,
      lastRecord: switch (vodingHistories.lastRecordTime) {
        final DateTime lastRecordTime => DateTime.now().difference(lastRecordTime).formatHHMM(),
        _ => 'N/A',
      },
    );
  }

  final int frequency;
  final int totalVoid;
  final String lastRecord;

  @override
  List<Object> get props => [
        frequency,
        totalVoid,
        lastRecord,
      ];
}
