import 'package:bladderly/domain/model/history.dart';
import 'package:bladderly/domain/model/history_status.dart';
import 'package:bladderly/domain/repository/history_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SaveIntakeHistoryUsecase {
  const SaveIntakeHistoryUsecase({
    required HistoryRepository historyRepository,
  }) : _historyRepository = historyRepository;

  final HistoryRepository _historyRepository;

  Future<Either<Exception, IntakeHistory>> call({
    required int? id,
    required String hashId,
    required DateTime recordTime,
    required String beverageType,
    required int recordVolume,
    String? memo,
  }) async {
    try {
      final voidingHistory = _historyRepository.saveIntakeHistory(
        IntakeHistory(
          id: id,
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
