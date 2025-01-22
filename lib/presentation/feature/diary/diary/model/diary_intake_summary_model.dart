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
      beverageTypeRateMap: intakeHistories.totalVolume <= 0
          ? {}
          : {
              for (final beverageType in BeverageTypeModel.values)
                beverageType:
                    intakeHistories.filterByBeverageType(beverageType.name).totalVolume / intakeHistories.totalVolume,
            },
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
