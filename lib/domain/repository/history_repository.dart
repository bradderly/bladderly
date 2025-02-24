import 'dart:io';

import 'package:bradderly/domain/model/histories.dart';
import 'package:bradderly/domain/model/history.dart';

abstract class HistoryRepository {
  Stream<Histories> getHistoriesStream({
    required String hashId,
    required DateTime recordDate,
  });

  /// save history to local
  VoidingHistory saveVoidngHistory(VoidingHistory vodingHistory);

  /// save history to local
  IntakeHistory saveIntakeHistory(IntakeHistory intakeHistory);

  /// save history to local
  LeakageHistory saveLeakageHistory(LeakageHistory leakageHistory);

  Stream<List<DateTime>> getHistoryDatesStream(String hashId);

  Future<void> exportHistories({
    required String hashId,
    required List<DateTime> dates,
  });

  Future<void> sendHistoriesExportReason({
    required String hashId,
    required String? doctorName,
    required String? clinicInformation,
  });

  Future<void> uploadVoidingSoundFile(File file);

  History? getHistoryById(int id);

  void deleteHistoryById(int id);

  Future<String?> uploadHistory({
    required String hashId,
    required History history,
  });
}
