import 'package:bradderly/data/isar/schema/history_entity.dart';
import 'package:bradderly/domain/model/history.dart';

class HistoryMapper {
  const HistoryMapper._();

  static History fromHistoryEntity(HistoryEntity entity) {
    if (entity.isIntake == true) {
      return IntakeHistory(
        id: entity.id,
        hashId: entity.hashId,
        recordTime: entity.recordTime,
        beverageType: entity.beverageType!,
        recordVolume: entity.recordVolume.toInt(),
        memo: entity.leakageMemo,
        status: entity.status,
      );
    }

    if (entity.recordVolume == 0.1) {
      return LeakageHistory(
        id: entity.id,
        hashId: entity.hashId,
        recordTime: entity.recordTime,
        leakageVolume: entity.leakageVolume!,
        memo: entity.leakageMemo,
        status: entity.status,
      );
    }

    return VoidingHistory(
      id: entity.id,
      hashId: entity.hashId,
      recordTime: entity.recordTime,
      recordVolume: entity.recordVolume.toInt(),
      recordUrgency: entity.recordUrgency!,
      isManual: entity.isManual ?? false,
      isNocutria: entity.isNocutria ?? false,
      isLeakage: entity.isLeakage ?? false,
      leakageVolume: entity.leakageVolume,
      memo: entity.leakageMemo,
      status: entity.status,
    );
  }
}
