import 'package:bradderly/domain/model/histories.dart';
import 'package:bradderly/domain/model/history.dart';

abstract class HistoryRepository {
  Future<void> initializeHistories();

  Future<void> removeHistoriesByHashId(String hashId);

  Stream<Histories<History>> getHistoriesStream({
    required String hashId,
    required DateTime date,
  });

  Future<VoidingHistory> saveManualVoidngHistory(VoidingHistory vodingHistory);

  Future<IntakeHistory> saveIntakeHistory(IntakeHistory intakeHistory);
}
