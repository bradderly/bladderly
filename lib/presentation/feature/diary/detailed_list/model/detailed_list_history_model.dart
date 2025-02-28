import 'package:bladderly/domain/model/history.dart';
import 'package:bladderly/domain/model/leakage_volume.dart';
import 'package:bladderly/presentation/common/model/beverage_type_model.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';
import 'package:equatable/equatable.dart';

sealed class DetailedListHistoryModel extends Equatable {
  const DetailedListHistoryModel._({
    required this.id,
    required this.memo,
  });

  factory DetailedListHistoryModel.fromHistory(History history) {
    return switch (history) {
      final VoidingHistory history => DetailedListVoidingHistoryModel._(
          id: history.id!,
          memo: history.memo,
          recordVolume: history.recordVolume,
          recordUrgency: history.recordUrgency,
          isNocutria: history.isNocturia,
          leakageVolume: switch (history.leakageVolume) {
            LeakageVolume.Small => 'S',
            LeakageVolume.Medium => 'M',
            LeakageVolume.Large => 'L',
            null => null,
          },
        ),
      final LeakageHistory history => DetailedListLeakageHistoryModel._(
          id: history.id!,
          memo: history.memo,
          leakageVolume: history.leakageVolume.name,
        ),
      final IntakeHistory history => DetailedListIntakeHistoryModel._(
          id: history.id!,
          memo: history.memo,
          beverageType: history.beverageType,
          recordVolume: history.recordVolume,
        ),
    };
  }

  final int id;
  final String? memo;

  @override
  List<Object?> get props => [
        id,
        memo,
      ];
}

class DetailedListVoidingHistoryModel extends DetailedListHistoryModel {
  const DetailedListVoidingHistoryModel._({
    required super.id,
    required super.memo,
    required this.recordVolume,
    required this.recordUrgency,
    required this.isNocutria,
    required this.leakageVolume,
  }) : super._();

  final int recordVolume;
  final int recordUrgency;
  final bool isNocutria;
  final String? leakageVolume;

  @override
  List<Object?> get props => [
        ...super.props,
        recordVolume,
        recordUrgency,
        leakageVolume,
      ];
}

class DetailedListLeakageHistoryModel extends DetailedListHistoryModel {
  const DetailedListLeakageHistoryModel._({
    required super.id,
    required super.memo,
    required this.leakageVolume,
  }) : super._();

  final String leakageVolume;

  @override
  List<Object?> get props => [
        ...super.props,
        leakageVolume,
      ];
}

class DetailedListIntakeHistoryModel extends DetailedListHistoryModel {
  const DetailedListIntakeHistoryModel._({
    required super.id,
    required super.memo,
    required this.beverageType,
    required this.recordVolume,
  }) : super._();

  final String beverageType;
  final int recordVolume;

  SvgGenImage get icon {
    return switch (BeverageTypeModel.of(beverageType)) {
      BeverageTypeModel.water => Assets.icon.icDetailedListWater,
      BeverageTypeModel.caffeine => Assets.icon.icDetailedListCaffeine,
      BeverageTypeModel.soda => Assets.icon.icDetailedListSoda,
      BeverageTypeModel.juice => Assets.icon.icDetailedListJuice,
      BeverageTypeModel.alcohol => Assets.icon.icDetailedListAlcohol,
      BeverageTypeModel.others => Assets.icon.icDetailedListOthers,
    };
  }

  @override
  List<Object?> get props => [
        ...super.props,
        beverageType,
        recordVolume,
      ];
}
