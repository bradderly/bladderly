import 'package:bradderly/domain/model/history.dart';
import 'package:bradderly/domain/model/history_status.dart';
import 'package:bradderly/domain/repository/history_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SaveIntakeHistoryUsecase {
  const SaveIntakeHistoryUsecase({
    required HistoryRepository historyRepository,
  }) : _historyRepository = historyRepository;

  final HistoryRepository _historyRepository;

  Future<Either<Exception, IntakeHistory>> call({
    required String hashId,
    required DateTime recordTime,
    required String beverageType,
    required int recordVolume,
    String? memo,
  }) async {
    try {
      final voidingHistory = await _historyRepository.saveIntakeHistory(
        IntakeHistory(
          hashId: hashId,
          recordTime: recordTime,
          beverageType: beverageType,
          recordVolume: recordVolume,
          status: HistoryStatus.done,
          memo: switch (memo) {
            final String memo when memo.trim().isNotEmpty => memo,
            _ => null,
          },
        ),
      );

      return Right(voidingHistory);
    } on Exception catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
