import 'package:bladderly/data/isar/schema/apple_credential_entity.dart';
import 'package:bladderly/data/isar/schema/history_entity.dart';
import 'package:bladderly/data/isar/schema/user_entity.dart';
import 'package:bladderly/domain/model/history_status.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

abstract class IsarClient {
  factory IsarClient(Isar isar) => _IsarClientImpl(isar: isar);

  HistoryEntity? getHistoryOrNullById(int id);

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

  // @override
  // UserEntity? getUserOrNull() {
  //   return _isar.userEntitys.where().build().findAllSync().firstOrNull;
  // }

  // @override
  // Stream<UserEntity> getUserStream() {
  //   return _isar.userEntitys.where().build().watch().map((entities) => entities.first);
  // }

  @override
  AppleCredentialEntity? getAppleCredentialOrNullByUserIdentifier(String userIdentifier) {
    return _isar.appleCredentialEntitys.filter().userIdentifierEqualTo(userIdentifier).findFirstSync();
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
      () {
        if (_isar.userEntitys.getByUserIdSync(userEntity.userId)?.id case final int id) {
          userEntity.id = id;
        }

        return _isar.userEntitys.getSync(_isar.userEntitys.putSync(userEntity))!;
      },
    );
  }

  @override
  void deleteUserByUserId(String userId) {
    return _isar.writeTxnSync(() => _isar.userEntitys.deleteByUserIdSync(userId));
  }

  @override
  void clearAll() {
    return _isar.clearSync();
  }
}
