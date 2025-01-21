import 'package:bradderly/domain/model/histories.dart';
import 'package:equatable/equatable.dart';

class HomeIntakeSummaryModel extends Equatable {
  const HomeIntakeSummaryModel({
    required this.totalVolume,
  });

  const HomeIntakeSummaryModel.none() : totalVolume = 0;

  factory HomeIntakeSummaryModel.fromDomain(IntakeHistories intakeHistories) {
    return HomeIntakeSummaryModel(totalVolume: intakeHistories.totalVolume);
  }

  final double totalVolume;

  @override
  List<Object?> get props => [
        totalVolume,
      ];
}
