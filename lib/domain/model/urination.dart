import 'package:bradderly/domain/model/leakage_volume.dart';
import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';

part 'urination.g.dart';

@Collection(ignore: {'props'})
class Urination extends Equatable {
  Id id = Isar.autoIncrement;

  @Name('hash_id')
  late String hashId;

  @Name('record_time')
  late DateTime recordTime;

  @Name('is_intake')
  bool? isIntake;

  @Name('is_manual')
  bool? isManual;

  @Name('record_volume')
  late double recordVolume;

  @Name('is_nocutria')
  bool? isNocutria;

  @Name('is_leakage')
  bool? isLeakage;

  @Name('leakage_volume')
  @Enumerated(EnumType.name)
  late LeakageVolume leakageVolume;

  @Name('beverage_type')
  @Enumerated(EnumType.name)
  String? beverageType;

  @Name('leakage_memo')
  String? leakageMemo;

  @override
  List<Object?> get props => [
        hashId,
        recordTime,
        isIntake,
        isManual,
        recordVolume,
        isNocutria,
        isLeakage,
        leakageVolume,
        beverageType,
        leakageMemo,
      ];
}
