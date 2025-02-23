import 'package:bradderly/data/isar/schema/history_entity.dart';
import 'package:bradderly/domain/model/history_status.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';

abstract class IsarClient {
  const IsarClient();

  HistoryEntity? getHistoryById(int id);

  int saveHistory(HistoryEntity historyEntity);

  void removeHistoryByHashIdAndRecordTime({
    required String hashId,
    required DateTime recordTime,
  });

  Stream<List<HistoryEntity>> getHistoriesStreamByHashIdAndDate({
    required String hashId,
    required DateTime recordDate,
  });

  Stream<List<DateTime>> getHistoryDatesStreamByHashId({
    required String hashId,
  });

  Stream<List<HistoryEntity>> getPendingUploadHistoriesStreamByHashId(
    String hashId,
  );

  List<HistoryEntity> getPendingUploadHistoriesByHashId(
    String hashId,
  );
}

@LazySingleton(as: IsarClient)
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
  void removeHistoryByHashIdAndRecordTime({required String hashId, required DateTime recordTime}) {
    return _isar
        .writeTxnSync(_isar.historyEntitys.filter().hashIdEqualTo(hashId).recordTimeEqualTo(recordTime).deleteAllSync);
  }

  @override
  Stream<List<HistoryEntity>> getHistoriesStreamByHashIdAndDate({
    required String hashId,
    required DateTime recordDate,
  }) {
    final lowerDate = DateUtils.dateOnly(recordDate);
    final upperDate = lowerDate.add(const Duration(days: 1));
    return _isar.historyEntitys
        .filter()
        .hashIdEqualTo(hashId)
        .recordTimeBetween(lowerDate, upperDate, includeUpper: false)
        .sortByRecordTime()
        .watch(fireImmediately: true);
  }

  @override
  Stream<List<DateTime>> getHistoryDatesStreamByHashId({required String hashId}) {
    return _isar.historyEntitys
        .filter()
        .hashIdEqualTo(hashId)
        .sortByRecordTime()
        .watch(fireImmediately: true)
        .map((entities) => entities.map((e) => DateUtils.dateOnly(e.recordTime)).toSet().toList());
  }

  @override
  Stream<List<HistoryEntity>> getPendingUploadHistoriesStreamByHashId(String hashId) {
    return _isar.historyEntitys.filter().hashIdEqualTo(hashId).statusEqualTo(HistoryStatus.pendingUpload).watch();
  }

  @override
  List<HistoryEntity> getPendingUploadHistoriesByHashId(String hashId) {
    return _isar.historyEntitys.filter().hashIdEqualTo(hashId).statusEqualTo(HistoryStatus.pendingUpload).findAllSync();
  }
}
