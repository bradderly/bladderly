import 'package:bradderly/domain/model/histories.dart';
import 'package:bradderly/presentation/common/model/beverage_type_model.dart';
import 'package:equatable/equatable.dart';

class DiaryIntakeSummaryModel extends Equatable {
  const DiaryIntakeSummaryModel({
    required this.totalVolume,
    required this.frequency,
    required this.beverageTypeRateMap,
  });

  const DiaryIntakeSummaryModel.none()
      : totalVolume = 0,
        frequency = 0,
        beverageTypeRateMap = const {};

  factory DiaryIntakeSummaryModel.fromDomain(IntakeHistories intakeHistories) {
    return DiaryIntakeSummaryModel(
      totalVolume: intakeHistories.totalVolume,
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

  final int totalVolume;
  final int frequency;
  final Map<BeverageTypeModel, double> beverageTypeRateMap;

  @override
  List<Object?> get props => [
        totalVolume,
        frequency,
        beverageTypeRateMap,
      ];
}
