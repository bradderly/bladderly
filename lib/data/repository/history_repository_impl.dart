import 'dart:io';

import 'package:bradderly/data/api/client/api_client.dart';
import 'package:bradderly/data/isar/schema/history_entity.dart';
import 'package:bradderly/data/mapper/history_entity_mapper.dart';
import 'package:bradderly/data/mapper/history_mapper.dart';
import 'package:bradderly/domain/model/histories.dart';
import 'package:bradderly/domain/model/history.dart';
import 'package:bradderly/domain/repository/history_repository.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';

@LazySingleton(as: HistoryRepository)
class HistoryRepositoryImpl implements HistoryRepository {
  const HistoryRepositoryImpl({
    required this.isar,
    required this.apiClient,
  });

  final Isar isar;
  final ApiClient apiClient;

  @override
  Future<void> initializeHistories() {
    return isar.writeTxn(Future.value);
  }

  @override
  Future<void> removeHistoriesByHashId(String hashId) {
    return isar.writeTxn(() => isar.historyEntitys.filter().hashIdEqualTo(hashId).deleteAll());
  }

  @override
  Stream<Histories> getHistoriesStream({
    required String hashId,
    required DateTime date,
  }) {
    final lowerDate = DateUtils.dateOnly(date);
    final upperDate = lowerDate.add(const Duration(days: 1));
    return isar.historyEntitys
        .filter()
        .hashIdEqualTo(hashId)
        .recordTimeBetween(lowerDate, upperDate, includeUpper: false)
        .sortByRecordTime()
        .watch(fireImmediately: true)
        .map((entities) => Histories(list: entities.map(HistoryMapper.fromHistoryEntity).toList()));
  }

  @override
  Future<VoidingHistory> saveVoidngHistory(VoidingHistory vodingHistory) {
    return isar.writeTxn(() async {
      final id = await isar.historyEntitys.put(HistoryEntityMapper.fromVoidingHistory(vodingHistory));
      return vodingHistory.setId(id);
    });
  }

  @override
  Future<IntakeHistory> saveIntakeHistory(IntakeHistory intakeHistory) {
    return isar.writeTxn(() async {
      final id = await isar.historyEntitys.put(HistoryEntityMapper.fromIntakeHistory(intakeHistory));
      return intakeHistory.setId(id);
    });
  }

  @override
  Stream<List<DateTime>> getHistoryDatesStream(String hashId) {
    return isar.historyEntitys
        .filter()
        .hashIdEqualTo(hashId)
        .sortByRecordTime()
        .watch(fireImmediately: true)
        .map((entities) => entities.map((e) => DateUtils.dateOnly(e.recordTime)).toSet().toList());
  }

  @override
  Future<void> exportHistories({required String email, required List<DateTime> dates}) {
    // TODO: implement exportHistories
    throw UnimplementedError();
  }

  @override
  Future<void> sendHistoriesExportReason() {
    // TODO: implement sendHistoriesExportReason
    throw UnimplementedError();
  }

  @override
  Future<void> uploadVoidingSoundFile(File file) async {}

  @override
  Future<LeakageHistory> saveLeakageHistory(LeakageHistory leakageHistory) {
    return isar.writeTxn(() async {
      final id = await isar.historyEntitys.put(HistoryEntityMapper.fromLeakageHistory(leakageHistory));
      return leakageHistory.setId(id);
    });
  }

  @override
  History? getHistoryById(int id) {
    if (isar.historyEntitys.getSync(id) case final HistoryEntity historyEntity) {
      return HistoryMapper.fromHistoryEntity(historyEntity);
    }

    return null;
  }

  @override
  void deleteHistoryById(int id) {
    return isar.writeTxnSync(() => isar.historyEntitys.deleteSync(id));
  }
}
