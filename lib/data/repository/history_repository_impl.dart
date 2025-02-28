import 'dart:io';

import 'package:bladderly/data/api/client/api_client.dart';
import 'package:bladderly/data/api/model/swagger_json.models.swagger.dart';
import 'package:bladderly/data/isar/isar_client.dart';
import 'package:bladderly/data/isar/schema/history_entity.dart';
import 'package:bladderly/data/mapper/history_entity_mapper.dart';
import 'package:bladderly/data/mapper/history_mapper.dart';
import 'package:bladderly/domain/model/histories.dart';
import 'package:bladderly/domain/model/history.dart';
import 'package:bladderly/domain/repository/history_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

@LazySingleton(as: HistoryRepository)
class HistoryRepositoryImpl implements HistoryRepository {
  const HistoryRepositoryImpl({
    required IsarClient isarClient,
    required ApiClient apiClient,
  })  : _isarClient = isarClient,
        _apiClient = apiClient;

  final IsarClient _isarClient;
  final ApiClient _apiClient;

  @override
  Stream<Histories> getHistoriesStream({
    required String userId,
    required DateTime recordDate,
  }) {
    return _isarClient
        .getHistoriesStreamByUserIdAndDate(userId: userId, recordDate: recordDate)
        .map((entities) => Histories(list: entities.map(HistoryMapper.fromHistoryEntity).toList()));
  }

  @override
  VoidingHistory saveVoidngHistory(VoidingHistory vodingHistory) {
    final id = _isarClient.saveHistory(HistoryEntityMapper.fromVoidingHistory(vodingHistory));
    return vodingHistory.setId(id);
  }

  @override
  IntakeHistory saveIntakeHistory(IntakeHistory intakeHistory) {
    final id = _isarClient.saveHistory(HistoryEntityMapper.fromIntakeHistory(intakeHistory));
    return intakeHistory.setId(id);
  }

  @override
  LeakageHistory saveLeakageHistory(LeakageHistory leakageHistory) {
    final id = _isarClient.saveHistory(HistoryEntityMapper.fromLeakageHistory(leakageHistory));
    return leakageHistory.setId(id);
  }

  @override
  Stream<List<DateTime>> getHistoryDatesStream(String userId) {
    return _isarClient.getHistoryDatesStreamByUserId(userId: userId);
  }

  @override
  Future<void> exportHistories({
    required String userId,
    required List<DateTime> dates,
  }) {
    return _apiClient.exportRecord(
      request: ExportReportRequest(
        userId: userId,
        exportDate: [
          for (final date in dates) DateFormat('yyyyMMdd').format(date),
        ],
      ),
    );
  }

  @override
  Future<void> sendHistoriesExportReason({
    required String userId,
    required String? doctorName,
    required String? clinicInformation,
  }) {
    return _apiClient.reportPurpose(
      request: DataExportSurveyRequest(
        userId: userId,
        doctor: doctorName,
        clinic: clinicInformation,
        select: doctorName == null && clinicInformation == null ? 0 : 1,
      ),
    );
  }

  @override
  Future<void> uploadVoidingSoundFile(File file) async {}

  @override
  History? getHistoryById(int id) {
    if (_isarClient.getHistoryOrNullById(id) case final HistoryEntity historyEntity) {
      return HistoryMapper.fromHistoryEntity(historyEntity);
    }

    return null;
  }

  @override
  Future<void> deleteHistoryById(int id) async {
    final history = _isarClient.getHistoryOrNullById(id);

    if (history == null) return;

    return _isarClient.removeHistoryByUserIdAndRecordTime(userId: history.userId, recordTime: history.recordTime);
  }

  @override
  Future<String?> uploadHistory({
    required String userId,
    required History history,
  }) async {
    final response = await _apiClient.updateRecord(
      request: RecordUpdateRequest(
        userId: userId,
        recDate: DateFormat('yyyyMMdd-hhmmss').format(history.recordTime),
        record: switch (history) {
          VoidingHistory() => RecordUpdateRequest$Record(
              isLeakage: history.isLeakage,
              isNocturia: history.isNocutria,
              recordVolume: '${history.recordVolume}',
              leakageVolume: history.leakageVolume?.name,
              recordUrgency: '${history.recordUrgency}',
              leakageMemo: history.memo,
              isManual: history.isManual,
            ),
          IntakeHistory() => RecordUpdateRequest$Record(
              beverageType: history.beverageType,
              leakageMemo: history.memo,
              recordVolume: '${history.recordVolume}',
              isIntake: true,
              isManual: true,
            ),
          LeakageHistory() => RecordUpdateRequest$Record(
              leakageVolume: history.leakageVolume.name,
              leakageMemo: history.memo,
              isLeakage: true,
              isManual: true,
            ),
        },
      ),
    );

    return response.body?.message;
  }
}
