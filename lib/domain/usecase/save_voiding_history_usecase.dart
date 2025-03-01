// Package imports:

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:bladderly/core/network_checker/network_checker.dart';
import 'package:bladderly/domain/model/history.dart';
import 'package:bladderly/domain/model/history_status.dart';
import 'package:bladderly/domain/model/leakage_volume.dart';
import 'package:bladderly/domain/repository/history_repository.dart';

@lazySingleton
class SaveVoidingHistoryUsecase {
  const SaveVoidingHistoryUsecase({
    required NetworkChecker networkChecker,
    required HistoryRepository historyRepository,
  })  : _networkChecker = networkChecker,
        _historyRepository = historyRepository;

  final NetworkChecker _networkChecker;
  final HistoryRepository _historyRepository;

  Future<Either<Exception, VoidingHistory>> call({
    required String userId,
    required int? id,
    required DateTime recordTime,
    required int recordVolume,
    required int recordUrgency,
    required bool isNocutria,
    required bool isLeakage,
    required LeakageVolume? leakageVolume,
    String? memo,
  }) async {
    try {
      final history = await _historyRepository.saveHistory(
        VoidingHistory(
          id: id,
          recordTime: recordTime,
          recordVolume: recordVolume,
          recordUrgency: recordUrgency,
          isNocturia: isNocutria,
          isLeakage: isLeakage,
          status: HistoryStatus.pending,
          leakageVolume: leakageVolume,
          memo: switch (memo) {
            final String memo when memo.trim().isNotEmpty => memo,
            _ => null,
          },
          isManual: true,
        ),
      );

      final isNetworkConnected = await _networkChecker.isConnected;

      if (!isNetworkConnected) return Right(history);

      await _historyRepository.uploadHistory(userId: userId, history: history);

      final doneHistory = await _historyRepository.saveHistory(history.setStatus(HistoryStatus.done));

      return Right(doneHistory);
    } on Exception catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
