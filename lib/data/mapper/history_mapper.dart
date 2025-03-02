// Project imports:
import 'package:bladderly/data/api/model/swagger_json.models.swagger.dart';
import 'package:bladderly/data/isar/schema/history_entity.dart';
import 'package:bladderly/domain/model/history.dart';
import 'package:bladderly/domain/model/history_status.dart';
import 'package:bladderly/domain/model/leakage_volume.dart';

class HistoryMapper {
  const HistoryMapper._();

  static History fromHistoryEntity(HistoryEntity entity) {
    if (entity.isIntake == true) {
      return IntakeHistory(
        id: entity.id,
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
        recordTime: entity.recordTime,
        leakageVolume: entity.leakageVolume!,
        memo: entity.leakageMemo,
        status: entity.status,
      );
    }

    return VoidingHistory(
      id: entity.id,
      recordTime: entity.recordTime,
      recordVolume: entity.recordVolume.toInt(),
      recordUrgency: entity.recordUrgency!,
      isManual: entity.isManual ?? false,
      isNocturia: entity.isNocturia ?? false,
      isLeakage: entity.isLeakage ?? false,
      leakageVolume: entity.leakageVolume,
      memo: entity.leakageMemo,
      status: entity.status,
    );
  }

  static History fromGetAllResultResponse$Records$Item(GetAllResultResponse$Records$Item record) {
    const status = HistoryStatus.done;
    final recordTime = DateTime.parse(record.recordTime!.replaceAll('-', ' '));
    final recordVolume = double.tryParse(record.recordVolume ?? '');
    final leakageVolume = switch (record.leakageVolume) {
      final String leakageVolume when leakageVolume.isNotEmpty => LeakageVolume.values.byName(leakageVolume),
      _ => null,
    };

    if (record.isIntake == true) {
      return IntakeHistory(
        id: null,
        recordTime: recordTime,
        beverageType: record.beverageType!,
        recordVolume: recordVolume!.toInt(),
        memo: record.leakageMemo,
        status: status,
      );
    }

    if (recordVolume == 0.1) {
      return LeakageHistory(
        id: null,
        recordTime: recordTime,
        leakageVolume: leakageVolume!,
        memo: record.leakageMemo,
        status: status,
      );
    }

    return VoidingHistory(
      id: null,
      recordTime: recordTime,
      recordVolume: recordVolume!.toInt(),
      recordUrgency: int.parse(record.recordUrgency!),
      isManual: record.isManual ?? false,
      isNocturia: record.isNocturia ?? false,
      isLeakage: record.isLeakage ?? false,
      leakageVolume: leakageVolume,
      memo: record.leakageMemo,
      status: status,
    );
  }

  static HistoryEntity toHistoryEntity(History history) {
    return switch (history) {
      VoidingHistory() => _voidingHistoryToHistoryEntity(history),
      IntakeHistory() => _intakeHistoryToHistoryEntity(history),
      LeakageHistory() => _leakageHistoryToHistoryEntity(history),
    };
  }

  static HistoryEntity _voidingHistoryToHistoryEntity(VoidingHistory history) {
    return HistoryEntity()
      ..setId(history.id)
      ..recordTime = history.recordTime
      ..leakageMemo = history.memo
      ..recordVolume = history.recordVolume.toDouble()
      ..recordUrgency = history.recordUrgency
      ..isManual = history.isManual
      ..isNocturia = history.isNocturia
      ..isLeakage = history.isLeakage
      ..leakageVolume = history.leakageVolume
      ..status = history.status;
  }

  static HistoryEntity _intakeHistoryToHistoryEntity(IntakeHistory history) {
    return HistoryEntity()
      ..setId(history.id)
      ..recordTime = history.recordTime
      ..leakageMemo = history.memo
      ..beverageType = history.beverageType
      ..recordVolume = history.recordVolume.toDouble()
      ..status = history.status
      ..isIntake = true;
  }

  static HistoryEntity _leakageHistoryToHistoryEntity(LeakageHistory history) {
    return HistoryEntity()
      ..setId(history.id)
      ..recordTime = history.recordTime
      ..leakageMemo = history.memo
      ..isLeakage = true
      ..leakageVolume = history.leakageVolume
      ..status = history.status
      ..recordVolume = 0.1;
  }
}
