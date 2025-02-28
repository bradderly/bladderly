import 'package:bladderly/domain/repository/history_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SynchronizeHistoriesUsecase {
  const SynchronizeHistoriesUsecase({
    required HistoryRepository historyRepository,
  }) : _historyRepository = historyRepository;

  final HistoryRepository _historyRepository;

  Future<Either<Exception, void>> call({required String userId}) async {
    try {
      final histories = await _historyRepository.getAllHistoriesFromServer(userId: userId);

      _historyRepository.saveHistories(histories);

      return const Right(null);
    } on Exception catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
