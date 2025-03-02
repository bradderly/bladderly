// Package imports:
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:bladderly/domain/repository/history_repository.dart';

@lazySingleton
class GetHistoryDatesStreamUsecase {
  const GetHistoryDatesStreamUsecase({required HistoryRepository historyRepository})
      : _historyRepository = historyRepository;

  final HistoryRepository _historyRepository;

  Either<Exception, Stream<List<DateTime>>> call() {
    try {
      final stream = _historyRepository.getHistoryDatesStream();

      return Right(stream);
    } on Exception catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
