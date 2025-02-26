import 'dart:io';

import 'package:bradderly/domain/model/histories.dart';
import 'package:bradderly/domain/model/history.dart';

abstract class HistoryRepository {
  Stream<Histories> getHistoriesStream({
    required String userId,
    required DateTime recordDate,
  });

  /// save history to local
  VoidingHistory saveVoidngHistory(VoidingHistory vodingHistory);

  /// save history to local
  IntakeHistory saveIntakeHistory(IntakeHistory intakeHistory);

  /// save history to local
  LeakageHistory saveLeakageHistory(LeakageHistory leakageHistory);

  Stream<List<DateTime>> getHistoryDatesStream(String userId);

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
}
