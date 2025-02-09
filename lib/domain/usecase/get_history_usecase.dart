import 'package:bradderly/domain/model/history.dart';
import 'package:bradderly/domain/repository/history_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetHistoryUsecase {
  const GetHistoryUsecase({required HistoryRepository historyRepository}) : _historyRepository = historyRepository;

  final HistoryRepository _historyRepository;

  Either<Exception, History?> call({
    required int historyId,
  }) {
    try {
      final history = _historyRepository.getHistoryById(historyId);
      return Right(history);
    } on Exception catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
