// Package imports:
// Project imports:
import 'package:bladderly/domain/mixin/history_result_usecase_mixin.dart';
import 'package:bladderly/domain/repository/history_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetHistoryResultsUsecase with HistoryResultUsecaseMixin {
  const GetHistoryResultsUsecase({
    required HistoryRepository historyRepository,
  }) : _historyRepository = historyRepository;

  final HistoryRepository _historyRepository;

  Future<Either<Exception, void>> call({
    required String userId,
  }) async {
    try {
      final histories = await historyRepository.getProcessingHistories();

      await Future.wait(histories.map((history) => getResult(userId: userId, history: history)));

      return const Right(null);
    } catch (e) {
      return Left(e is Exception ? e : Exception(e.toString()));
    }
  }

  @override
  HistoryRepository get historyRepository => _historyRepository;
}
