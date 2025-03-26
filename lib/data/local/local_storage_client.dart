import 'package:bladderly/data/local/schema/apple_credential_entity.dart';
import 'package:bladderly/data/local/schema/history_entity.dart';
import 'package:bladderly/data/local/schema/membership_entity.dart';
import 'package:bladderly/data/local/schema/rate_trigger_entity.dart';
import 'package:bladderly/data/local/schema/score_entity.dart';
import 'package:bladderly/data/local/schema/user_entity.dart';

abstract class LocalStorageClient {
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

  Future<void> clearAll();

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
