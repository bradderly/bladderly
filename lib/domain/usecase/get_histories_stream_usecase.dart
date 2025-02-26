import 'package:bradderly/domain/model/histories.dart';
import 'package:bradderly/domain/repository/history_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetHistoriesStreamUsecase {
  const GetHistoriesStreamUsecase({required HistoryRepository historyRepository})
      : _historyRepository = historyRepository;

  final HistoryRepository _historyRepository;

  Either<Exception, Stream<Histories>> call({
    required String userId,
    required DateTime dateTime,
  }) {
    try {
      return Right(_historyRepository.getHistoriesStream(userId: userId, recordDate: dateTime));
    } on Exception catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
