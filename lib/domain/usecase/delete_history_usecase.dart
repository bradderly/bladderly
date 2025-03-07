// Package imports:
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:bladderly/domain/repository/history_repository.dart';

@lazySingleton
class DeleteHistoryUsecase {
  const DeleteHistoryUsecase({required HistoryRepository historyRepository}) : _historyRepository = historyRepository;

  final HistoryRepository _historyRepository;

  Either<Exception, void> call({
    required int historyId,
  }) {
    try {
      final history = _historyRepository.deleteHistoryById(historyId);
      return Right(history);
    } on Exception catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
