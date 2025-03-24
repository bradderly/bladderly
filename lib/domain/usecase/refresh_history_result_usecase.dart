import 'package:bladderly/core/network_checker/network_checker.dart';
import 'package:bladderly/core/recorder/recorder_module.dart';
import 'package:bladderly/domain/exception/get_history_result_failure_exception.dart';
import 'package:bladderly/domain/exception/network_not_connected_exception.dart';
import 'package:bladderly/domain/exception/not_found_user_exception.dart';
import 'package:bladderly/domain/mixin/history_result_usecase_mixin.dart';
import 'package:bladderly/domain/model/history.dart';
import 'package:bladderly/domain/model/history_status.dart';
import 'package:bladderly/domain/repository/history_repository.dart';
import 'package:bladderly/domain/repository/user_repository.dart';
import 'package:bladderly/domain/util/recorded_file_util.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RefreshHistoryResultUsecase with HistoryResultUsecaseMixin {
  const RefreshHistoryResultUsecase({
    required HistoryRepository historyRepository,
    required NetworkChecker networkChecker,
    required UserRepository userRepository,
    required RecorderFileLoader recorderFileLoader,
    required RecordedFileUtil recordedFileUtil,
  })  : _historyRepository = historyRepository,
        _networkChecker = networkChecker,
        _userRepository = userRepository,
        _recorderFileLoader = recorderFileLoader,
        _recordedFileUtil = recordedFileUtil;

  final HistoryRepository _historyRepository;
  final NetworkChecker _networkChecker;
  final UserRepository _userRepository;
  final RecorderFileLoader _recorderFileLoader;
  final RecordedFileUtil _recordedFileUtil;

  Future<Either<Exception, void>> call({
    required String userId,
    required int historyId,
  }) async {
    // if (!await _networkChecker.isConnected) throw const NetworkNotConnectedException();
    if (!await _networkChecker.isConnected) {
      return const Left(
        NetworkNotConnectedException(),
      );
    }
    final user =
        _userRepository.getUserOrNullByUserId(userId) ?? (throw const NotFoundUserException(message: 'User not found'));

    final history = _historyRepository.getHistoryById(historyId);

    if (history is! VoidingHistory) return const Right(null);

    if (history.isManual || (history.status != HistoryStatus.failed && history.status != HistoryStatus.pending)) {
      return const Right(null);
    }

    try {
      await _historyRepository.saveHistory(history.setStatus(HistoryStatus.processing));

      final file = _recorderFileLoader.getFile(history.recordTime);
      final isFileExist = file.existsSync();

      if (isFileExist) {
        await _historyRepository.uploadVoidingSoundFile(
          fileName: _recordedFileUtil.generateFileName(file: file, user: user),
          file: file,
        );
      }

      await _historyRepository.uploadHistory(userId: userId, history: history);

      await getResult(userId: userId, history: history);

      return const Right(null);
    } catch (e) {
      if (e is GetHistoryResultFailureException) {
        await _historyRepository.saveHistory(history.setStatus(HistoryStatus.done));
      }

      return Left(e is Exception ? e : Exception(e.toString()));
    }
  }

  @override
  HistoryRepository get historyRepository => _historyRepository;
}
