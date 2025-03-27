// Dart imports:
import 'dart:io';

// Project imports:
import 'package:bladderly/core/package_device_info/src/model/device_info_model.dart';
import 'package:bladderly/data/api/client/api_client.dart';
import 'package:bladderly/data/api/model/swagger_json.models.swagger.dart';
import 'package:bladderly/data/local/local_storage_client.dart';
import 'package:bladderly/data/local/schema/history_entity.dart';
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
    required LocalStorageClient localStorageClient,
    required ApiClient apiClient,
    required DeviceInfoModel deviceInfoModel,
  })  : _localStorageClient = localStorageClient,
        _apiClient = apiClient,
        _deviceInfoModel = deviceInfoModel;

  final LocalStorageClient _localStorageClient;
  final ApiClient _apiClient;
  final DeviceInfoModel _deviceInfoModel;

  @override
  Stream<Histories> getHistoriesStream({
    required DateTime recordDate,
  }) {
    return _localStorageClient
        .getHistoriesStreamByRecordDate(recordDate: recordDate)
        .map((entities) => Histories(list: entities.map(HistoryMapper.fromHistoryEntity).toList()));
  }

  @override
  Future<T> saveHistory<T extends History>(T history) async {
    final id =
        await _localStorageClient.saveHistory(HistoryMapper.toHistoryEntity(history)).then((entity) => entity.id);

    return history.setId(id) as T;
  }

  @override
  Future<Histories> saveHistories(Histories<History> histories) {
    return _localStorageClient
        .saveHistories(histories.map(HistoryMapper.toHistoryEntity).toList())
        .then((histories) => Histories(list: histories.map(HistoryMapper.fromHistoryEntity).toList()));
  }

  @override
  Stream<List<DateTime>> getHistoryDatesStream() {
    return _localStorageClient.getHistoryDatesStream();
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
        device: _deviceInfoModel.os,
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
    if (_localStorageClient.getHistoryOrNullById(id) case final HistoryEntity historyEntity) {
      return HistoryMapper.fromHistoryEntity(historyEntity);
    }

    return null;
  }

  @override
  Future<void> deleteHistoryById(int id) async {
    final history = _localStorageClient.getHistoryOrNullById(id);

    if (history == null) return;

    return _localStorageClient.removeHistoryByRecordTime(recordTime: history.recordTime);
  }

  @override
  Future<String?> uploadHistory({
    required String userId,
    required History history,
    DateTime? originRecordTime,
  }) async {
    final recordTime = DateFormat('yyyyMMdd-HHmmss').format(originRecordTime ?? history.recordTime);
    final newRecDate = originRecordTime == null ? null : DateFormat('yyyyMMdd-HHmmss').format(history.recordTime);
    final deleteTime = history.deletedAt == null ? null : DateFormat('yyyyMMdd-HHmmss').format(history.recordTime);

    final response = await _apiClient.updateRecord(
      request: RecordUpdateRequest(
        userId: userId,
        // originRecordTime 이 있으면 수정 아니면 생성
        recDate: recordTime,
        record: switch (history) {
          VoidingHistory() => RecordUpdateRequest$Record(
              isLeakage: history.isLeakage,
              isNocturia: history.isNocturia,
              recordVolume: '${history.recordVolume}',
              leakageVolume: history.leakageVolume?.name,
              recordUrgency: '${history.recordUrgency}',
              leakageMemo: history.memo,
              isManual: history.isManual,
              newRecDate: newRecDate,
              deleteTime: deleteTime,
            ),
          IntakeHistory() => RecordUpdateRequest$Record(
              beverageType: history.beverageType,
              leakageMemo: history.memo,
              recordVolume: '${history.recordVolume}',
              isIntake: true,
              isManual: true,
              newRecDate: newRecDate,
              deleteTime: deleteTime,
            ),
          LeakageHistory() => RecordUpdateRequest$Record(
              leakageVolume: history.leakageVolume.name,
              leakageMemo: history.memo,
              isLeakage: true,
              isManual: true,
              newRecDate: newRecDate,
              deleteTime: deleteTime,
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

    return Histories(
      list: records.map(HistoryMapper.fromGetAllResultResponseList).whereType<History>().toList(),
    );
  }

  @override
  Future<Histories<History>> getPendingHistories() {
    return _localStorageClient
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
    final entities = await _localStorageClient.getProcessingHistories();

    return Histories(list: entities.map(HistoryMapper.fromHistoryEntity).whereType<VoidingHistory>().toList());
  }

  @override
  History? getHistoryByRecordTime(DateTime recordTime) {
    if (_localStorageClient.getHistoryOrNullByRecordTime(recordTime) case final HistoryEntity historyEntity) {
      return HistoryMapper.fromHistoryEntity(historyEntity);
    }

    return null;
  }

  @override
  Future<void> deleteHistoryByRecordTimeFromServer({required String userId, required DateTime recordTime}) {
    return _apiClient
        .updateRecord(
          request: RecordUpdateRequest(
            userId: userId,
            recDate: DateFormat('yyyyMMdd-HHmmss').format(recordTime),
            record: RecordUpdateRequest$Record(deleteTime: DateFormat('yyyyMMdd-HHmmss').format(recordTime)),
          ),
        )
        .then((response) => response.body!);
  }
}
