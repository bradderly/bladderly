import 'package:bradderly/domain/model/history.dart';
import 'package:bradderly/domain/model/history_status.dart';
import 'package:bradderly/domain/model/leakage_volume.dart';
import 'package:bradderly/domain/repository/history_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SaveLeakageHistoryUsecase {
  const SaveLeakageHistoryUsecase({
    required HistoryRepository historyRepository,
  }) : _historyRepository = historyRepository;

  final HistoryRepository _historyRepository;

  Future<Either<Exception, LeakageHistory>> call({
    required int? id,
    required String hashId,
    required DateTime recordTime,
    required LeakageVolume leakageVolume,
    String? memo,
  }) async {
    try {
      final voidingHistory = await _historyRepository.saveLeakageHistory(
        LeakageHistory(
          id: id,
          hashId: hashId,
          recordTime: recordTime,
          leakageVolume: leakageVolume,
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
