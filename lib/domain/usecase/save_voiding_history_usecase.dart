import 'package:bladderly/domain/model/history.dart';
import 'package:bladderly/domain/model/history_status.dart';
import 'package:bladderly/domain/model/leakage_volume.dart';
import 'package:bladderly/domain/repository/history_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SaveVoidingHistoryUsecase {
  const SaveVoidingHistoryUsecase({
    required HistoryRepository historyRepository,
  }) : _historyRepository = historyRepository;

  final HistoryRepository _historyRepository;

  Future<Either<Exception, VoidingHistory>> call({
    required int? id,
    required String hashId,
    required DateTime recordTime,
    required int recordVolume,
    required int recordUrgency,
    required bool isNocutria,
    required bool isLeakage,
    required LeakageVolume? leakageVolume,
    String? memo,
  }) async {
    try {
      final voidingHistory = _historyRepository.saveVoidngHistory(
        VoidingHistory(
          id: id,
          hashId: hashId,
          recordTime: recordTime,
          recordVolume: recordVolume,
          recordUrgency: recordUrgency,
          isNocutria: isNocutria,
          isLeakage: isLeakage,
          status: HistoryStatus.done,
          leakageVolume: leakageVolume,
          memo: switch (memo) {
            final String memo when memo.trim().isNotEmpty => memo,
            _ => null,
          },
          isManual: true,
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
