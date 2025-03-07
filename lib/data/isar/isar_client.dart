// Flutter imports:

// Project imports:
import 'package:bladderly/data/isar/schema/apple_credential_entity.dart';
import 'package:bladderly/data/isar/schema/history_entity.dart';
import 'package:bladderly/data/isar/schema/user_entity.dart';
import 'package:bladderly/domain/model/history_status.dart';
// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:isar/isar.dart';

abstract class IsarClient {
  factory IsarClient(Isar isar) => _IsarClientImpl(isar: isar);

  HistoryEntity? getHistoryOrNullById(int id);

  Future<HistoryEntity> saveHistory(HistoryEntity historyEntity);

  Future<List<HistoryEntity>> saveHistories(List<HistoryEntity> historyEntities);

  void removeHistoryByRecordTime({required DateTime recordTime});

  Stream<List<HistoryEntity>> getHistoriesStreamByRecordDate({required DateTime recordDate});

  Stream<List<DateTime>> getHistoryDatesStream();

  AppleCredentialEntity? getAppleCredentialOrNullByUserIdentifier(String userIdentifier);

  AppleCredentialEntity saveAppleCredential(AppleCredentialEntity appleCredentialEntity);

  UserEntity? getUserOrNullByUserId(String userId);

  UserEntity saveUser(UserEntity userEntity);

  void deleteUserByUserId(String userId);

  void clearAll();

  Future<List<HistoryEntity>> getPendingHistories();

  Future<List<HistoryEntity>> getProcessingHistories();
}

class _IsarClientImpl implements IsarClient {
  const _IsarClientImpl({required Isar isar}) : _isar = isar;

  final Isar _isar;

  @override
  HistoryEntity? getHistoryOrNullById(int id) {
    return _isar.historyEntitys.getSync(id);
  }

  @override
  Future<HistoryEntity> saveHistory(HistoryEntity historyEntity) {
    return _isar.writeTxn(() async {
      final id = await _isar.historyEntitys.put(historyEntity);
      return _isar.historyEntitys.get(id).then((value) => value!);
    });
  }

  @override
  void removeHistoryByRecordTime({
    required DateTime recordTime,
  }) {
    return _isar.writeTxnSync(() => _isar.historyEntitys.deleteByRecordTimeSync(recordTime));
  }

  @override
  Stream<List<HistoryEntity>> getHistoriesStreamByRecordDate({
    required DateTime recordDate,
  }) {
    final lowerDate = DateUtils.dateOnly(recordDate);
    final upperDate = lowerDate.add(const Duration(days: 1));
    return _isar.historyEntitys
        .filter()
        .recordTimeBetween(lowerDate, upperDate, includeUpper: false)
        .sortByRecordTime()
        .watch(fireImmediately: true);
  }

  @override
  Stream<List<DateTime>> getHistoryDatesStream() {
    return _isar.historyEntitys
        .where()
        .watch(fireImmediately: true)
        .map((entities) => entities.map((e) => DateUtils.dateOnly(e.recordTime)).toSet().toList());
  }

  @override
  AppleCredentialEntity? getAppleCredentialOrNullByUserIdentifier(String userIdentifier) {
    return _isar.appleCredentialEntitys.getByUserIdentifierSync(userIdentifier);
  }

  @override
  AppleCredentialEntity saveAppleCredential(AppleCredentialEntity appleCredentialEntity) {
    return _isar.writeTxnSync(
      () => _isar.appleCredentialEntitys.getSync(_isar.appleCredentialEntitys.putSync(appleCredentialEntity))!,
    );
  }

  @override
  UserEntity? getUserOrNullByUserId(String userId) {
    return _isar.userEntitys.filter().userIdEqualTo(userId).findFirstSync();
  }

  @override
  UserEntity saveUser(UserEntity userEntity) {
    return _isar.writeTxnSync(
      () => _isar.userEntitys.getSync(_isar.userEntitys.putByUserIdSync(userEntity))!,
    );
  }

  @override
  void deleteUserByUserId(String userId) {
    return _isar.writeTxnSync(() => _isar.userEntitys.deleteByUserIdSync(userId));
  }

  @override
  void clearAll() {
    return _isar.writeTxnSync(_isar.clearSync);
  }

  @override
  Future<List<HistoryEntity>> saveHistories(List<HistoryEntity> historyEntities) {
    return _isar.writeTxn(() async {
      final ids = await _isar.historyEntitys.putAllByRecordTime(historyEntities);
      return _isar.historyEntitys.getAll(ids).then((entities) => entities.whereType<HistoryEntity>().toList());
    });
  }

  @override
  Future<List<HistoryEntity>> getPendingHistories() {
    return _isar.historyEntitys.filter().statusEqualTo(HistoryStatus.pending).findAll();
  }

  @override
  Future<List<HistoryEntity>> getProcessingHistories() {
    return _isar.historyEntitys.filter().statusEqualTo(HistoryStatus.processing).findAll();
  }
}
