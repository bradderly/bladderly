import 'dart:io';

import 'package:bladderly/domain/model/history.dart';
import 'package:bladderly/domain/model/history_status.dart';
import 'package:bladderly/domain/repository/history_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SaveVoidingHistoryWithFileUsecase {
  const SaveVoidingHistoryWithFileUsecase({
    required HistoryRepository historyRepository,
  }) : _historyRepository = historyRepository;

  final HistoryRepository _historyRepository;

  Future<Either<Exception, VoidingHistory>> call({
    required DateTime recordTime,
    required int recordUrgency,
    required bool isNocutria,
    required bool isLeakage,
    required File file,
    String? memo,
  }) async {
    try {
      await _historyRepository.uploadVoidingSoundFile(file);

      final voidingHistory = await _historyRepository.saveVoidngHistory(
        VoidingHistory(
          id: null,
          recordTime: recordTime,
          recordUrgency: recordUrgency,
          isNocturia: isNocutria,
          isLeakage: isLeakage,
          memo: memo,
          isManual: false,
          recordVolume: 0,
          leakageVolume: null,
          status: HistoryStatus.processing,
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
