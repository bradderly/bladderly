// Flutter imports:

// Project imports:
import 'package:bladderly/data/isar/schema/apple_credential_entity.dart';
import 'package:bladderly/data/isar/schema/history_entity.dart';
import 'package:bladderly/data/isar/schema/membership_entity.dart';
import 'package:bladderly/data/isar/schema/rate_trigger_entity.dart';
import 'package:bladderly/data/isar/schema/score_entity.dart';
import 'package:bladderly/data/isar/schema/user_entity.dart';
import 'package:bladderly/domain/model/history_status.dart';
// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:isar/isar.dart';

abstract class IsarClient {
  factory IsarClient(Isar isar) => _IsarClientImpl(isar: isar);

  HistoryEntity? getHistoryOrNullById(int id);

  HistoryEntity? getHistoryOrNullByRecordTime(DateTime recordTime);

  Future<HistoryEntity> saveHistory(HistoryEntity historyEntity);

  Future<List<HistoryEntity>> saveHistories(List<HistoryEntity> historyEntities);

  void removeHistoryByRecordTime({required DateTime recordTime});

  Stream<List<HistoryEntity>> getHistoriesStreamByRecordDate({required DateTime recordDate});

  Stream<List<DateTime>> getHistoryDatesStream();

  AppleCredentialEntity? getAppleCredentialOrNullByUserIdentifier(String userIdentifier);

  AppleCredentialEntity saveAppleCredential(AppleCredentialEntity appleCredentialEntity);

  UserEntity? getUserOrNullByUserId(String userId);

  UserEntity saveUser(UserEntity userEntity);

  UserEntity migrateUser(String userId, UserEntity userEntity);

  void deleteUserByUserId(String userId);

  void clearAll();

  Future<List<HistoryEntity>> getPendingHistories();

  Future<List<HistoryEntity>> getProcessingHistories();

  Stream<UserEntity?> get userStream;

  Future<List<ScoreEntity>> saveScores(List<ScoreEntity> scoreEntities);

  Future<ScoreEntity> saveScore(ScoreEntity scoreEntity);

  Stream<List<ScoreEntity>> getScoresStream();

  Stream<MembershipEntity?> getMembershipStreamByUserId(int userId);

  MembershipEntity saveMembership(MembershipEntity membershipEntity);

  Future<RateTriggerEntity> getRateTrigger();

  Future<void> updateRateTrigger(RateTriggerEntity rateTriggerEntity);
  MembershipEntity? getMembershipOrNullByUserId(int userId);
}

class _IsarClientImpl implements IsarClient {
  const _IsarClientImpl({required Isar isar}) : _isar = isar;

  final Isar _isar;

  @override
  HistoryEntity? getHistoryOrNullById(int id) {
    return _isar.historyEntitys.getSync(id);
  }

  @override
  HistoryEntity? getHistoryOrNullByRecordTime(DateTime recordTime) {
    return _isar.historyEntitys.getByRecordTimeSync(recordTime);
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
    if (historyEntities.isEmpty) return Future.value([]);

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

  @override
  Stream<UserEntity?> get userStream =>
      _isar.userEntitys.where().watch(fireImmediately: true).map((entities) => entities.firstOrNull);

  @override
  Future<List<ScoreEntity>> saveScores(List<ScoreEntity> scoreEntities) {
    if (scoreEntities.isEmpty) return Future.value([]);

    return _isar.writeTxn(() async {
      final ids = await _isar.scoreEntitys.putAll(scoreEntities);

      return _isar.scoreEntitys.getAll(ids).then((entities) => entities.whereType<ScoreEntity>().toList());
    });
  }

  @override
  Future<ScoreEntity> saveScore(ScoreEntity scoreEntity) {
    return _isar.writeTxn(() async {
      final id = await _isar.scoreEntitys.put(scoreEntity);

      return _isar.scoreEntitys.get(id).then((value) => value!);
    });
  }

  @override
  Stream<List<ScoreEntity>> getScoresStream() {
    return _isar.scoreEntitys.where().sortByDateDesc().watch(fireImmediately: true);
  }

  @override
  Stream<MembershipEntity?> getMembershipStreamByUserId(int userId) {
    return _isar.membershipEntitys
        .filter()
        .userIdEqualTo(userId)
        .watch(fireImmediately: true)
        .map((entites) => entites.firstOrNull);
  }

  @override
  MembershipEntity saveMembership(MembershipEntity membershipEntity) {
    return _isar.writeTxnSync(
      () => _isar.membershipEntitys.getSync(_isar.membershipEntitys.putByUserIdSync(membershipEntity))!,
    );
  }

  @override
  UserEntity migrateUser(String userId, UserEntity userEntity) {
    return _isar.writeTxnSync(() {
      final id = _isar.userEntitys.getByUserIdSync(userId)!.id;

      userEntity.id = id;

      return _isar.userEntitys.getSync(_isar.userEntitys.putSync(userEntity))!;
    });
  }

  @override
  Future<RateTriggerEntity> getRateTrigger() async {
    final rateTrigger = await _isar.rateTriggerEntitys.where().findFirst();
    if (rateTrigger == null) {
      final newTrigger = RateTriggerEntity();
      final id = await _isar.writeTxn(() {
        return _isar.rateTriggerEntitys.put(newTrigger);
        ;
      });
      final insertedTrigger = await _isar.rateTriggerEntitys.get(id);
      return insertedTrigger!;
    }
    return rateTrigger;
  }

  @override
  Future<void> updateRateTrigger(RateTriggerEntity rateTriggerEntity) async {
    await _isar.writeTxn(() => _isar.rateTriggerEntitys.put(rateTriggerEntity));
  MembershipEntity? getMembershipOrNullByUserId(int userId) {
    return _isar.membershipEntitys.getByUserIdSync(userId);
  }
}
