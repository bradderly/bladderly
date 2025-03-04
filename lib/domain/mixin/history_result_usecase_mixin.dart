// Project imports:
import 'package:bladderly/domain/model/history.dart';
import 'package:bladderly/domain/model/history_status.dart';
import 'package:bladderly/domain/repository/history_repository.dart';

mixin HistoryResultUsecaseMixin {
  HistoryRepository get historyRepository;

  Future<void> getResult({
    required String userId,
    required History history,
  }) async {
    if (history is! VoidingHistory || history.isManual) {
      return;
    }

    const maximumRetryCount = 12;

    for (var i = 1; i <= maximumRetryCount; i++) {
      final result = await historyRepository.getHistoryResult(
        userId: userId,
        recordTime: history.recordTime,
      );

      if (i == maximumRetryCount) {
        await historyRepository.saveHistory(history.setStatus(HistoryStatus.failed));
        break;
      }

      if (result.volume case final int volume when result.isDone) {
        await historyRepository.saveHistory(history.setStatus(HistoryStatus.done).setRecordVolume(volume));
        break;
      }

      await Future<void>.delayed(const Duration(seconds: 5));
    }
  }
}
