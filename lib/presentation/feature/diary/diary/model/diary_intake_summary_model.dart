// Package imports:
// Project imports:
import 'package:bladderly/domain/model/histories.dart';
import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/num_extension.dart';
import 'package:bladderly/presentation/common/model/beverage_type_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class DiaryIntakeSummaryModel extends Equatable {
  const DiaryIntakeSummaryModel({
    required List<int> volumes,
    required this.frequency,
    required this.beverageTypeRateMap,
  }) : _volumes = volumes;

  const DiaryIntakeSummaryModel.none()
      : _volumes = const [],
        frequency = 0,
        beverageTypeRateMap = const {};

  factory DiaryIntakeSummaryModel.fromDomain(IntakeHistories intakeHistories) {
    return DiaryIntakeSummaryModel(
      volumes: intakeHistories.map((history) => history.recordVolume.toRoundVolume()).toList(),
      frequency: intakeHistories.length,
      beverageTypeRateMap: BeverageTypeModel.values
          .map((beverateType) => MapEntry(beverateType, intakeHistories.getVolumeRateByBeverageType(beverateType.name)))
          .where((entry) => entry.value > 0)
          .fold<Map<BeverageTypeModel, double>>(
        {},
        (previousValue, element) => previousValue..[element.key] = element.value,
      ),
    );
  }

  final List<int> _volumes;
  final int frequency;
  final Map<BeverageTypeModel, double> beverageTypeRateMap;

  int getTotalVolume(BuildContext context) {
    return _volumes.map(context.unitValue).fold<int>(0, (previousValue, element) => previousValue + element);
  }

  @override
  List<Object?> get props => [
        _volumes,
        frequency,
        beverageTypeRateMap,
      ];
}
