import 'package:bladderly/domain/model/histories.dart';
import 'package:bladderly/domain/repository/history_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetHistoriesStreamUsecase {
  const GetHistoriesStreamUsecase({required HistoryRepository historyRepository})
      : _historyRepository = historyRepository;

  final HistoryRepository _historyRepository;

  Either<Exception, Stream<Histories>> call({
    required DateTime dateTime,
  }) {
    try {
      return Right(_historyRepository.getHistoriesStream(recordDate: dateTime));
    } on Exception catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
