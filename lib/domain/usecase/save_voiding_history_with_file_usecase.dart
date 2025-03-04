// Package imports:

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:bladderly/core/network_checker/network_checker.dart';
import 'package:bladderly/core/recorder/recorder_module.dart';
import 'package:bladderly/domain/exception/not_found_user_exception.dart';
import 'package:bladderly/domain/exception/not_found_voiding_sound_file_exception.dart';
import 'package:bladderly/domain/model/history.dart';
import 'package:bladderly/domain/model/history_status.dart';
import 'package:bladderly/domain/repository/auth_repository.dart';
import 'package:bladderly/domain/repository/history_repository.dart';
import 'package:bladderly/domain/util/recorded_file_util.dart';

@lazySingleton
class SaveVoidingHistoryWithFileUsecase {
  const SaveVoidingHistoryWithFileUsecase({
    required RecorderFileLoader recorderFileLoader,
    required RecordedFileUtil recordedFileUtil,
    required NetworkChecker networkChecker,
    required AuthRepository authRepository,
    required HistoryRepository historyRepository,
  })  : _recorderFileLoader = recorderFileLoader,
        _recordedFileUtil = recordedFileUtil,
        _networkChecker = networkChecker,
        _authRepository = authRepository,
        _historyRepository = historyRepository;

  final RecorderFileLoader _recorderFileLoader;
  final RecordedFileUtil _recordedFileUtil;
  final NetworkChecker _networkChecker;
  final AuthRepository _authRepository;
  final HistoryRepository _historyRepository;

  Future<Either<Exception, VoidingHistory>> call({
    required String userId,
    required DateTime recordTime,
    required int recordUrgency,
    required bool isNocutria,
    required bool isLeakage,
    String? memo,
  }) async {
    try {
      final user = _authRepository.getUserOrNullByUserId(userId) ??
          (throw const NotFoundUserException(message: 'User not found'));

      final file = _recorderFileLoader.getFile(recordTime)..readAsBytesSync();

      if (!file.existsSync()) {
        throw const NotFoundVoidingSoundFileException(message: 'Voiding sound file not found');
      }

      final history = await _historyRepository.saveHistory(
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
          status: HistoryStatus.pending,
        ),
      );

      final isNetworkConnected = await _networkChecker.isConnected;

      if (!isNetworkConnected) return Right(history);

      await _historyRepository.uploadVoidingSoundFile(
        fileName: _recordedFileUtil.generateFileName(file: file, user: user),
        file: file,
      );

      final processingHistory = await _historyRepository.saveHistory(history.setStatus(HistoryStatus.processing));

      return Right(processingHistory);
    } on Exception catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
