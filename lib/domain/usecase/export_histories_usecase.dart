// Package imports:
// Project imports:
import 'package:bladderly/domain/repository/history_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ExportHistoriesUsecase {
  const ExportHistoriesUsecase({
    required HistoryRepository historyRepository,
  }) : _historyRepository = historyRepository;

  final HistoryRepository _historyRepository;

  Future<Either<Exception, void>> call({
    required String userId,
    required String email,
    required List<DateTime> dates,
  }) async {
    try {
      final result = await _historyRepository.exportHistories(
        userId: userId,
        email: email,
        dates: dates,
      );
      return Right(result);
    } on Exception catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
