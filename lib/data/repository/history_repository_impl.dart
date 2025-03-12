// Dart imports:
import 'dart:io';

// Project imports:
import 'package:bladderly/data/api/client/api_client.dart';
import 'package:bladderly/data/api/model/swagger_json.models.swagger.dart';
import 'package:bladderly/data/isar/isar_client.dart';
import 'package:bladderly/data/isar/schema/history_entity.dart';
import 'package:bladderly/data/mapper/history_mapper.dart';
import 'package:bladderly/domain/exception/get_history_result_failure_exception.dart';
import 'package:bladderly/domain/model/histories.dart';
import 'package:bladderly/domain/model/history.dart';
import 'package:bladderly/domain/model/history_result.dart';
import 'package:bladderly/domain/repository/history_repository.dart';
// Package imports:
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
    required String email,
    required List<DateTime> dates,
  }) {
    return _apiClient.exportRecord(
      request: ExportReportRequest(
        userId: userId,
        email: email,
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
    DateTime? originRecordTime,
  }) async {
    final response = await _apiClient.updateRecord(
      request: RecordUpdateRequest(
        userId: userId,
        // originRecordTime 이 있으면 수정 아니면 생성
        recDate: DateFormat('yyyyMMdd-HHmmss').format(originRecordTime ?? history.recordTime),
        record: switch (history) {
          VoidingHistory() => RecordUpdateRequestRecord(
              isLeakage: history.isLeakage,
              isNocturia: history.isNocturia,
              recordVolume: '${history.recordVolume}',
              leakageVolume: history.leakageVolume?.name,
              recordUrgency: '${history.recordUrgency}',
              leakageMemo: history.memo,
              isManual: history.isManual,
              newRecDate: originRecordTime == null ? null : DateFormat('yyyyMMdd-HHmmss').format(history.recordTime),
            ),
          IntakeHistory() => RecordUpdateRequestRecord(
              beverageType: history.beverageType,
              leakageMemo: history.memo,
              recordVolume: '${history.recordVolume}',
              isIntake: true,
              isManual: true,
              newRecDate: originRecordTime == null ? null : DateFormat('yyyyMMdd-HHmmss').format(history.recordTime),
            ),
          LeakageHistory() => RecordUpdateRequestRecord(
              leakageVolume: history.leakageVolume.name,
              leakageMemo: history.memo,
              isLeakage: true,
              isManual: true,
              newRecDate: originRecordTime == null ? null : DateFormat('yyyyMMdd-HHmmss').format(history.recordTime),
            ),
        },
      ),
    );

    return response.body?.message;
  }

  // TODO(eden): 레코드, 스코어 둘다 불러오기 때문에 레포지토리 분리해야함
  @override
  Future<Histories> getAllHistoriesFromServer(String userId) async {
    final response = await _apiClient.getAllRecords(userId: userId).then((response) => response.body!);
    final records = response.records ?? [];

    return Histories(
      list: records.map(HistoryMapper.fromGetAllResultResponseList).whereType<History>().toList(),
    );
  }

  @override
  Future<Histories<History>> getPendingHistories() {
    return _isarClient
        .getPendingHistories()
        .then((histories) => Histories(list: histories.map(HistoryMapper.fromHistoryEntity).toList()));
  }

  @override
  Future<HistoryResult> getHistoryResult({
    required String userId,
    required DateTime recordTime,
  }) async {
    final response = await _apiClient
        .getResult(recDate: DateFormat('yyyyMMdd-HHmmss').format(recordTime), userId: userId)
        .then((response) => response.body!);

    final isDone = switch (response.message) {
      'success' => true,
      _ => false,
    };

    if (response.errorType case final String errorType) {
      throw GetHistoryResultFailureException.errorType(
        errorType: errorType,
        recordTime: recordTime,
      );
    }

    return HistoryResult(
      isDone: isDone,
      result: response.result,
    );
  }

  @override
  Future<Histories<VoidingHistory>> getProcessingHistories() async {
    final entities = await _isarClient.getProcessingHistories();

    return Histories(list: entities.map(HistoryMapper.fromHistoryEntity).whereType<VoidingHistory>().toList());
  }

  @override
  History? getHistoryByRecordTime(DateTime recordTime) {
    if (_isarClient.getHistoryOrNullByRecordTime(recordTime) case final HistoryEntity historyEntity) {
      return HistoryMapper.fromHistoryEntity(historyEntity);
    }

    return null;
  }
}
