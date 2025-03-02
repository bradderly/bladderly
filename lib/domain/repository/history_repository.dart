// Dart imports:
import 'dart:io';

// Project imports:
import 'package:bladderly/domain/model/histories.dart';
import 'package:bladderly/domain/model/history.dart';

abstract class HistoryRepository {
  Stream<Histories> getHistoriesStream({
    required DateTime recordDate,
  });

  /// save history to local
  Future<T> saveHistory<T extends History>(T history);

  /// save histories to local
  Future<Histories> saveHistories(Histories histories);

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

  Future<void> uploadVoidingSoundFile({
    required String fileName,
    required File file,
  });

  History? getHistoryById(int id);

  void deleteHistoryById(int id);

  Future<String?> uploadHistory({
    required String userId,
    required History history,
  });

  Future<Histories> getAllHistoriesFromServer(String userId);

  Future<Histories> getPendingHistories();
}
