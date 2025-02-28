import 'dart:io';

import 'package:bladderly/domain/model/histories.dart';
import 'package:bladderly/domain/model/history.dart';

abstract class HistoryRepository {
  Stream<Histories> getHistoriesStream({
    required DateTime recordDate,
  });

  /// save history to local
  Future<VoidingHistory> saveVoidngHistory(VoidingHistory vodingHistory);

  /// save history to local
  Future<IntakeHistory> saveIntakeHistory(IntakeHistory intakeHistory);

  /// save history to local
  Future<LeakageHistory> saveLeakageHistory(LeakageHistory leakageHistory);

  /// save history to local
  Histories saveHistories(Histories histories);

  Stream<List<DateTime>> getHistoryDatesStream();

  Future<void> exportHistories({
    required String userId,
    required List<DateTime> dates,
  });

  Future<void> sendHistoriesExportReason({
    required String userId,
    required String? doctorName,
    required String? clinicInformation,
  });

  Future<void> uploadVoidingSoundFile(File file);

  History? getHistoryById(int id);

  void deleteHistoryById(int id);

  Future<String?> uploadHistory({
    required String userId,
    required History history,
  });

  Future<Histories> getAllHistoriesFromServer({required String userId});
}
