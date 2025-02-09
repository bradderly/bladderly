import 'dart:io';

import 'package:bradderly/domain/model/histories.dart';
import 'package:bradderly/domain/model/history.dart';

abstract class HistoryRepository {
  Future<void> initializeHistories();

  Future<void> removeHistoriesByHashId(String hashId);

  Stream<Histories> getHistoriesStream({
    required String hashId,
    required DateTime date,
  });

  Future<VoidingHistory> saveVoidngHistory(VoidingHistory vodingHistory);

  Future<IntakeHistory> saveIntakeHistory(IntakeHistory intakeHistory);

  Future<LeakageHistory> saveLeakageHistory(LeakageHistory leakageHistory);

  Stream<List<DateTime>> getHistoryDatesStream(String hashId);

  Future<void> exportHistories({
    required String email,
    required List<DateTime> dates,
  });

  Future<void> sendHistoriesExportReason();

  Future<void> uploadVoidingSoundFile(File file);

  History? getHistoryById(int id);
}
