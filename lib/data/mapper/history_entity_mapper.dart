import 'package:bradderly/data/isar/schema/history_entity.dart';
import 'package:bradderly/domain/model/history.dart';

class HistoryEntityMapper {
  const HistoryEntityMapper._();

  static HistoryEntity fromVoidingHistory(VoidingHistory history) {
    return HistoryEntity()
      ..hashId = history.hashId
      ..recordTime = history.recordTime
      ..leakageMemo = history.memo
      ..recordVolume = history.recordVolume
      ..recordUrgency = history.recordUrgency
      ..isManual = history.isManual
      ..isNocutria = history.isNocutria
      ..isLeakage = history.isLeakage
      ..leakageVolume = history.leakageVolume;
  }

  static HistoryEntity fromIntakeHistory(IntakeHistory history) {
    return HistoryEntity()
      ..hashId = history.hashId
      ..recordTime = history.recordTime
      ..leakageMemo = history.memo
      ..beverageType = history.beverageType
      ..recordVolume = history.recordVolume
      ..isIntake = true;
  }
}
