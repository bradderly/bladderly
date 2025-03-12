// Package imports:

// Project imports:
import 'package:bladderly/core/network_checker/network_checker.dart';
import 'package:bladderly/domain/model/history.dart';
import 'package:bladderly/domain/model/history_status.dart';
import 'package:bladderly/domain/repository/history_repository.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
// Package imports:
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SaveIntakeHistoryUsecase {
  const SaveIntakeHistoryUsecase({
    required NetworkChecker networkChecker,
    required HistoryRepository historyRepository,
  })  : _networkChecker = networkChecker,
        _historyRepository = historyRepository;

  final NetworkChecker _networkChecker;
  final HistoryRepository _historyRepository;

  Future<Either<Exception, IntakeHistory>> call({
    required String userId,
    required int? id,
    required DateTime recordTime,
    required String beverageType,
    required String recordVolume,
    String? memo,
  }) async {
    try {
      final history = await _historyRepository.saveHistory(
        IntakeHistory(
          id: id,
          recordTime: recordTime,
          beverageType: beverageType,
          recordVolume: recordVolume,
          roundedVolume: recordVolume.getRoundedVolume(),
          status: HistoryStatus.pending,
          memo: switch (memo) {
            final String memo when memo.trim().isNotEmpty => memo,
            _ => null,
          },
        ),
      );

      final isNetworkConnected = await _networkChecker.isConnected;

      if (!isNetworkConnected) return Right(history);

      await _historyRepository.uploadHistory(userId: userId, history: history);

      final doneHistory = await _historyRepository.saveHistory(history.setStatus(HistoryStatus.done));

      return Right(doneHistory);
    } catch (e) {
      return Left(e is Exception ? e : Exception(e.toString()));
    }
  }
}
