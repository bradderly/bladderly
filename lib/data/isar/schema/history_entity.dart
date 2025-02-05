import 'package:bradderly/domain/model/history_status.dart';
import 'package:bradderly/domain/model/leakage_volume.dart';
import 'package:isar/isar.dart';

part 'history_entity.g.dart';

@collection
class HistoryEntity {
  HistoryEntity();

  Id id = Isar.autoIncrement;

  @Name('hash_id')
  @Index(composite: [CompositeIndex('recordTime')])
  late String hashId;

  @Name('record_time')
  late DateTime recordTime;

  @Name('is_intake')
  bool? isIntake;

  @Name('record_urgency')
  int? recordUrgency;

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
  LeakageVolume? leakageVolume;

  @Name('beverage_type')
  @Enumerated(EnumType.name)
  String? beverageType;

  @Name('leakage_memo')
  String? leakageMemo;

  @Name('status')
  @Enumerated(EnumType.name)
  late HistoryStatus status;
}
