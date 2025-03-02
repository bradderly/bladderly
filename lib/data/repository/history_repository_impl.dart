// Dart imports:
import 'dart:io';

// Package imports:
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:bladderly/data/api/client/api_client.dart';
import 'package:bladderly/data/api/model/swagger_json.models.swagger.dart';
import 'package:bladderly/data/isar/isar_client.dart';
import 'package:bladderly/data/isar/schema/history_entity.dart';
import 'package:bladderly/data/mapper/history_mapper.dart';
import 'package:bladderly/domain/model/histories.dart';
import 'package:bladderly/domain/model/history.dart';
import 'package:bladderly/domain/repository/history_repository.dart';

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
    required DateTime recordDate,
  }) {
    return _isarClient
        .getHistoriesStreamByRecordDate(recordDate: recordDate)
        .map((entities) => Histories(list: entities.map(HistoryMapper.fromHistoryEntity).toList()));
  }

  @override
  Future<T> saveHistory<T extends History>(T history) async {
    final id = await _isarClient.saveHistory(HistoryMapper.toHistoryEntity(history)).then((entity) => entity.id);

    return history.setId(id) as T;
  }

  @override
  Future<Histories> saveHistories(Histories<History> histories) {
    return _isarClient
        .saveHistories(histories.map(HistoryMapper.toHistoryEntity).toList())
        .then((histories) => Histories(list: histories.map(HistoryMapper.fromHistoryEntity).toList()));
  }

  @override
  Stream<List<DateTime>> getHistoryDatesStream() {
    return _isarClient.getHistoryDatesStream();
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
  Future<void> uploadVoidingSoundFile({
    required String fileName,
    required File file,
  }) {
    return _apiClient.uploadAudio(
      fileName: fileName,
      audioBytes: file.readAsBytesSync(),
    );
  }

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

    return _isarClient.removeHistoryByRecordTime(recordTime: history.recordTime);
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
              isNocturia: history.isNocturia,
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

  @override
  Future<Histories> getAllHistoriesFromServer(String userId) async {
    final response = await _apiClient.getAllRecords(userId: userId).then((response) => response.body!);
    final records = response.records ?? [];

    return Histories(list: records.map(HistoryMapper.fromGetAllResultResponse$Records$Item).toList());
  }

  @override
  Future<Histories<History>> getPendingHistories() {
    return _isarClient
        .getPendingHistories()
        .then((histories) => Histories(list: histories.map(HistoryMapper.fromHistoryEntity).toList()));
  }
}
