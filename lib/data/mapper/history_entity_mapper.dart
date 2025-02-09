import 'package:bradderly/data/isar/schema/history_entity.dart';
import 'package:bradderly/domain/model/history.dart';

class HistoryEntityMapper {
  const HistoryEntityMapper._();

  static HistoryEntity fromVoidingHistory(VoidingHistory history) {
    return HistoryEntity()
      ..setId(history.id)
      ..hashId = history.hashId
      ..recordTime = history.recordTime
      ..leakageMemo = history.memo
      ..recordVolume = history.recordVolume.toDouble()
      ..recordUrgency = history.recordUrgency
      ..isManual = history.isManual
      ..isNocutria = history.isNocutria
      ..isLeakage = history.isLeakage
      ..leakageVolume = history.leakageVolume
      ..status = history.status;
  }

  static HistoryEntity fromIntakeHistory(IntakeHistory history) {
    return HistoryEntity()
      ..setId(history.id)
      ..hashId = history.hashId
      ..recordTime = history.recordTime
      ..leakageMemo = history.memo
      ..beverageType = history.beverageType
      ..recordVolume = history.recordVolume.toDouble()
      ..status = history.status
      ..isIntake = true;
  }

  static HistoryEntity fromLeakageHistory(LeakageHistory history) {
    return HistoryEntity()
      ..setId(history.id)
      ..hashId = history.hashId
      ..recordTime = history.recordTime
      ..leakageMemo = history.memo
      ..isLeakage = true
      ..leakageVolume = history.leakageVolume
      ..status = history.status
      ..recordVolume = 0.1;
  }
}
