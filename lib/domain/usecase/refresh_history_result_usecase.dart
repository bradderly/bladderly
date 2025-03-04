import 'package:bladderly/domain/mixin/history_result_usecase_mixin.dart';
import 'package:bladderly/domain/model/history.dart';
import 'package:bladderly/domain/model/history_status.dart';
import 'package:bladderly/domain/repository/history_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RefreshHistoryResultUsecase with HistoryResultUsecaseMixin {
  const RefreshHistoryResultUsecase({
    required HistoryRepository historyRepository,
  }) : _historyRepository = historyRepository;

  final HistoryRepository _historyRepository;

  Future<Either<Exception, void>> call({
    required String userId,
    required int historyId,
  }) async {
    try {
      final history = _historyRepository.getHistoryById(historyId);

      if (history is! VoidingHistory) return const Right(null);

      if (history.isManual || history.status != HistoryStatus.failed) return const Right(null);

      await _historyRepository.saveHistory(history.setStatus(HistoryStatus.processing));

      await getResult(userId: userId, history: history);

      return const Right(null);
    } catch (e) {
      return Left(e is Exception ? e : Exception(e.toString()));
    }
  }

  @override
  HistoryRepository get historyRepository => _historyRepository;
}
