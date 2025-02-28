import 'package:bladderly/domain/model/history_status.dart';
import 'package:bladderly/domain/model/leakage_volume.dart';
import 'package:isar/isar.dart';

part 'history_entity.g.dart';

@collection
class HistoryEntity {
  HistoryEntity();

  Id id = Isar.autoIncrement;

  @Name('record_time')
  @Index(unique: true, replace: true)
  late DateTime recordTime;

  @Name('is_intake')
  bool? isIntake;

  @Name('record_urgency')
  int? recordUrgency;

  @Name('is_manual')
  bool? isManual;

  @Name('record_volume')
  late double recordVolume;

  @Name('is_nocturia')
  bool? isNocturia;

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

  void setId(int? id) => this.id = id ?? this.id;

  bool isEqualTo(HistoryEntity entity) {
    if (recordTime != entity.recordTime) return false;

    if (isIntake != entity.isIntake) return false;

    if (recordUrgency != entity.recordUrgency) return false;

    if (isManual != entity.isManual) return false;

    if (recordVolume != entity.recordVolume) return false;

    if (isNocturia != entity.isNocturia) return false;

    if (isLeakage != entity.isLeakage) return false;

    if (leakageVolume != entity.leakageVolume) return false;

    if (beverageType != entity.beverageType) return false;

    if (leakageMemo != entity.leakageMemo) return false;

    if (status != entity.status) return false;

    return true;
  }
}
