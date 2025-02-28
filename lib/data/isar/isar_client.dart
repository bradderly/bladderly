import 'package:bladderly/data/isar/schema/apple_credential_entity.dart';
import 'package:bladderly/data/isar/schema/history_entity.dart';
import 'package:bladderly/data/isar/schema/user_entity.dart';
import 'package:bladderly/domain/model/history_status.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

abstract class IsarClient {
  factory IsarClient(Isar isar) => _IsarClientImpl(isar: isar);

  HistoryEntity? getHistoryOrNullById(int id);

  Future<int> saveHistory(HistoryEntity historyEntity);

  Future<List<int>> saveHistories(List<HistoryEntity> historyEntities);

  void removeHistoryByRecordTime({required DateTime recordTime});

  Stream<List<HistoryEntity>> getHistoriesStreamByRecordDate({required DateTime recordDate});

  Stream<List<DateTime>> getHistoryDatesStream();

  List<HistoryEntity> getPendingUploadHistories();

  AppleCredentialEntity? getAppleCredentialOrNullByUserIdentifier(String userIdentifier);

  AppleCredentialEntity saveAppleCredential(AppleCredentialEntity appleCredentialEntity);

  UserEntity? getUserOrNullByUserId(String userId);

  UserEntity saveUser(UserEntity userEntity);

  void deleteUserByUserId(String userId);

  void clearAll();
}

class _IsarClientImpl implements IsarClient {
  const _IsarClientImpl({required Isar isar}) : _isar = isar;

  final Isar _isar;

  @override
  HistoryEntity? getHistoryOrNullById(int id) {
    return _isar.historyEntitys.getSync(id);
  }

  @override
  Future<int> saveHistory(HistoryEntity historyEntity) {
    return _isar.writeTxn(() => _isar.historyEntitys.put(historyEntity));
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
  List<HistoryEntity> getPendingUploadHistories() {
    return _isar.historyEntitys.filter().statusEqualTo(HistoryStatus.pendingUpload).findAllSync();
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
  Future<List<int>> saveHistories(List<HistoryEntity> historyEntities) {
    return _isar.writeTxnSync(() => _isar.historyEntitys.putAllByRecordTime(historyEntities));
  }
}
