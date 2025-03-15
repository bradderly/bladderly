// Package imports:
// Project imports:
import 'package:bladderly/core/network_checker/network_checker.dart';
import 'package:bladderly/domain/model/history_status.dart';
import 'package:bladderly/domain/repository/history_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DeleteHistoryUsecase {
  const DeleteHistoryUsecase({
    required HistoryRepository historyRepository,
    required NetworkChecker networkChecker,
  })  : _historyRepository = historyRepository,
        _networkChecker = networkChecker;

  final HistoryRepository _historyRepository;
  final NetworkChecker _networkChecker;

  Future<Either<Exception, void>> call({
    required String userId,
    required int historyId,
  }) async {
    try {
      final history = _historyRepository.getHistoryById(historyId);

      if (history == null) return const Right(null);

      await _historyRepository.saveHistory(history.setStatus(HistoryStatus.pending).setDeletedAt(DateTime.now()));

      if (await _networkChecker.isConnected) {
        await _historyRepository.deleteHistoryByRecordTimeFromServer(userId: userId, recordTime: history.recordTime);
        _historyRepository.deleteHistoryById(historyId);
      }

      return const Right(null);
    } catch (e) {
      return Left(e is Exception ? e : Exception(e.toString()));
    }
  }
}
