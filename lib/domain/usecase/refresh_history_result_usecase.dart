import 'package:bladderly/core/network_checker/network_checker.dart';
import 'package:bladderly/domain/exception/get_history_result_failure_exception.dart';
import 'package:bladderly/domain/exception/network_not_connected_exception.dart';
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
    required NetworkChecker networkChecker,
  })  : _historyRepository = historyRepository,
        _networkChecker = networkChecker;

  final HistoryRepository _historyRepository;
  final NetworkChecker _networkChecker;

  Future<Either<Exception, void>> call({
    required String userId,
    required int historyId,
  }) async {
    if (!await _networkChecker.isConnected) throw const NetworkNotConnectedException();

    final history = _historyRepository.getHistoryById(historyId);

    if (history is! VoidingHistory) return const Right(null);

    if (history.isManual || history.status != HistoryStatus.failed) return const Right(null);

    try {
      await _historyRepository.saveHistory(history.setStatus(HistoryStatus.processing));

      await getResult(userId: userId, history: history);

      return const Right(null);
    } catch (e) {
      if (e is GetHistoryResultFailureException) {
        await _historyRepository.saveHistory(history.setStatus(HistoryStatus.done));
      }

      return Left(e is Exception ? e : Exception(e.toString()));
    }
  }

  @override
  HistoryRepository get historyRepository => _historyRepository;
}
