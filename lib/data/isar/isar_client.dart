import 'package:bradderly/data/isar/schema/history_entity.dart';
import 'package:bradderly/data/isar/schema/user_entity.dart';
import 'package:bradderly/domain/model/history_status.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

abstract class IsarClient {
  factory IsarClient(Isar isar) => _IsarClientImpl(isar: isar);

  HistoryEntity? getHistoryById(int id);

  int saveHistory(HistoryEntity historyEntity);

  void removeHistoryByUserIdAndRecordTime({
    required String userId,
    required DateTime recordTime,
  });

  Stream<List<HistoryEntity>> getHistoriesStreamByUserIdAndDate({
    required String userId,
    required DateTime recordDate,
  });

  Stream<List<DateTime>> getHistoryDatesStreamByUserId({
    required String userId,
  });

  Stream<List<HistoryEntity>> getPendingUploadHistoriesStreamByUserId(
    String userId,
  );

  List<HistoryEntity> getPendingUploadHistoriesByUserId(
    String userId,
  );

  UserEntity? getUserOrNull();

  Stream<UserEntity> getUserStream();
}

class _IsarClientImpl implements IsarClient {
  const _IsarClientImpl({required Isar isar}) : _isar = isar;

  final Isar _isar;

  @override
  HistoryEntity? getHistoryById(int id) {
    return _isar.historyEntitys.getSync(id);
  }

  @override
  int saveHistory(HistoryEntity historyEntity) {
    return _isar.writeTxnSync(() => _isar.historyEntitys.putSync(historyEntity));
  }

  @override
  void removeHistoryByUserIdAndRecordTime({required String userId, required DateTime recordTime}) {
    return _isar
        .writeTxnSync(_isar.historyEntitys.filter().userIdEqualTo(userId).recordTimeEqualTo(recordTime).deleteAllSync);
  }

  @override
  Stream<List<HistoryEntity>> getHistoriesStreamByUserIdAndDate({
    required String userId,
    required DateTime recordDate,
  }) {
    final lowerDate = DateUtils.dateOnly(recordDate);
    final upperDate = lowerDate.add(const Duration(days: 1));
    return _isar.historyEntitys
        .filter()
        .userIdEqualTo(userId)
        .recordTimeBetween(lowerDate, upperDate, includeUpper: false)
        .sortByRecordTime()
        .watch(fireImmediately: true);
  }

  @override
  Stream<List<DateTime>> getHistoryDatesStreamByUserId({required String userId}) {
    return _isar.historyEntitys
        .filter()
        .userIdEqualTo(userId)
        .sortByRecordTime()
        .watch(fireImmediately: true)
        .map((entities) => entities.map((e) => DateUtils.dateOnly(e.recordTime)).toSet().toList());
  }

  @override
  Stream<List<HistoryEntity>> getPendingUploadHistoriesStreamByUserId(String userId) {
    return _isar.historyEntitys.filter().userIdEqualTo(userId).statusEqualTo(HistoryStatus.pendingUpload).watch();
  }

  @override
  List<HistoryEntity> getPendingUploadHistoriesByUserId(String userId) {
    return _isar.historyEntitys.filter().userIdEqualTo(userId).statusEqualTo(HistoryStatus.pendingUpload).findAllSync();
  }

  @override
  UserEntity? getUserOrNull() {
    return _isar.userEntitys.where().build().findAllSync().firstOrNull;
  }

  @override
  Stream<UserEntity> getUserStream() {
    return _isar.userEntitys.where().build().watch().map((entities) => entities.first);
  }
}
