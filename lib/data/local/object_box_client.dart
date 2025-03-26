import 'package:bladderly/data/local/local_storage_client.dart';
import 'package:bladderly/data/local/objectbox.g.dart';
import 'package:bladderly/data/local/schema/apple_credential_entity.dart';
import 'package:bladderly/data/local/schema/history_entity.dart';
import 'package:bladderly/data/local/schema/membership_entity.dart';
import 'package:bladderly/data/local/schema/rate_trigger_entity.dart';
import 'package:bladderly/data/local/schema/score_entity.dart';
import 'package:bladderly/data/local/schema/user_entity.dart';
import 'package:bladderly/domain/model/history_status.dart';
import 'package:flutter/material.dart';

class ObjectBoxClient implements LocalStorageClient {
  ObjectBoxClient({
    required this.store,
  })  : userRepository = store.box<UserEntity>(),
        historyRepository = store.box<HistoryEntity>(),
        appleCredentialRepository = store.box<AppleCredentialEntity>(),
        membershipRepository = store.box<MembershipEntity>(),
        rateTriggerRepository = store.box<RateTriggerEntity>(),
        scoreRepository = store.box<ScoreEntity>();

  final Store store;

  final Box<AppleCredentialEntity> appleCredentialRepository;
  final Box<HistoryEntity> historyRepository;
  final Box<MembershipEntity> membershipRepository;
  final Box<RateTriggerEntity> rateTriggerRepository;
  final Box<ScoreEntity> scoreRepository;
  final Box<UserEntity> userRepository;

  @override
  Future<void> clearAll() {
    return Future.wait([
      appleCredentialRepository.removeAllAsync(),
      historyRepository.removeAllAsync(),
      membershipRepository.removeAllAsync(),
      rateTriggerRepository.removeAllAsync(),
      scoreRepository.removeAllAsync(),
      userRepository.removeAllAsync(),
    ]);
  }

  @override
  void deleteUserByUserId(String userId) {
    userRepository.query(UserEntity_.userId.equals(userId)).build().remove();
  }

  @override
  AppleCredentialEntity? getAppleCredentialOrNullByUserIdentifier(String userIdentifier) {
    return appleCredentialRepository
        .query(AppleCredentialEntity_.userIdentifier.equals(userIdentifier))
        .build()
        .findUnique();
  }

  @override
  Stream<List<HistoryEntity>> getHistoriesStreamByRecordDate({
    required DateTime recordDate,
  }) {
    final lowerDate = DateUtils.dateOnly(recordDate);
    final upperDate = lowerDate.add(const Duration(days: 1, milliseconds: -1));
    return historyRepository
        .query(HistoryEntity_.recordTime.betweenDate(lowerDate, upperDate))
        .watch(triggerImmediately: true)
        .map((event) => event.find());
  }

  @override
  Stream<List<DateTime>> getHistoryDatesStream() {
    return historyRepository
        .query()
        .watch(triggerImmediately: true)
        .map((event) => event.find())
        .map((histories) => histories.map((history) => DateUtils.dateOnly(history.recordTime)).toSet().toList());
  }

  @override
  HistoryEntity? getHistoryOrNullById(int id) {
    return historyRepository.get(id);
  }

  @override
  HistoryEntity? getHistoryOrNullByRecordTime(DateTime recordTime) {
    return historyRepository.query(HistoryEntity_.recordTime.equalsDate(recordTime)).build().findUnique();
  }

  @override
  MembershipEntity? getMembershipOrNullByUserId(int userId) {
    return membershipRepository.query(MembershipEntity_.userId.equals(userId)).build().findUnique();
  }

  @override
  Stream<MembershipEntity?> getMembershipStreamByUserId(int userId) {
    return membershipRepository
        .query(MembershipEntity_.userId.equals(userId))
        .watch(triggerImmediately: true)
        .map((event) => event.findUnique());
  }

  @override
  Future<List<HistoryEntity>> getPendingHistories() {
    return historyRepository.query(HistoryEntity_.status.equals(HistoryStatus.pending.name)).build().findAsync();
  }

  @override
  Future<List<HistoryEntity>> getProcessingHistories() {
    return historyRepository.query(HistoryEntity_.status.equals(HistoryStatus.processing.name)).build().findAsync();
  }

  @override
  Future<RateTriggerEntity> getRateTrigger() {
    final entity = rateTriggerRepository.query().build().findFirst();

    if (entity != null) return Future.value(entity);

    return rateTriggerRepository.putAndGetAsync(RateTriggerEntity());
  }

  @override
  Stream<List<ScoreEntity>> getScoresStream() {
    return scoreRepository.query().watch(triggerImmediately: true).map((event) => event.find());
  }

  @override
  UserEntity? getUserOrNullByUserId(String userId) {
    return userRepository.query(UserEntity_.userId.equals(userId)).build().findUnique();
  }

  @override
  UserEntity migrateUser(String userId, UserEntity userEntity) {
    final entity = getUserOrNullByUserId(userId);

    if (entity == null) throw Exception('User not found');

    userEntity.id = entity.id;

    return saveUser(userEntity);
  }

  @override
  void removeHistoryByRecordTime({required DateTime recordTime}) {
    historyRepository.query(HistoryEntity_.recordTime.equalsDate(recordTime)).build().remove();
  }

  @override
  AppleCredentialEntity saveAppleCredential(AppleCredentialEntity appleCredentialEntity) {
    final id = appleCredentialRepository.put(appleCredentialEntity);
    return appleCredentialRepository.get(id)!;
  }

  @override
  Future<List<HistoryEntity>> saveHistories(List<HistoryEntity> historyEntities) {
    return historyRepository.putAndGetManyAsync(historyEntities);
  }

  @override
  Future<HistoryEntity> saveHistory(HistoryEntity historyEntity) {
    return historyRepository.putAndGetAsync(historyEntity);
  }

  @override
  MembershipEntity saveMembership(MembershipEntity membershipEntity) {
    return membershipRepository.get(membershipRepository.put(membershipEntity))!;
  }

  @override
  Future<ScoreEntity> saveScore(ScoreEntity scoreEntity) {
    return scoreRepository.putAndGetAsync(scoreEntity);
  }

  @override
  Future<List<ScoreEntity>> saveScores(List<ScoreEntity> scoreEntities) {
    return scoreRepository
        .putManyAsync(scoreEntities)
        .then(scoreRepository.getMany)
        .then((entities) => entities.whereType<ScoreEntity>().toList());
  }

  @override
  UserEntity saveUser(UserEntity userEntity) {
    return userRepository.get(userRepository.put(userEntity))!;
  }

  @override
  Future<void> updateRateTrigger(RateTriggerEntity rateTriggerEntity) {
    return rateTriggerRepository.putAsync(rateTriggerEntity);
  }

  @override
  Stream<UserEntity?> get userStream =>
      userRepository.query().watch(triggerImmediately: true).map((event) => event.findUnique());
}
