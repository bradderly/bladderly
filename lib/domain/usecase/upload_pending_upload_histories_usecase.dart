// Package imports:

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:bladderly/core/recorder/recorder_module.dart';
import 'package:bladderly/domain/exception/not_found_user_exception.dart';
import 'package:bladderly/domain/model/history.dart';
import 'package:bladderly/domain/model/history_status.dart';
import 'package:bladderly/domain/model/user.dart';
import 'package:bladderly/domain/repository/auth_repository.dart';
import 'package:bladderly/domain/repository/history_repository.dart';
import 'package:bladderly/domain/util/recorded_file_util.dart';

@lazySingleton
class UploadPendingHistoriesUsecase {
  const UploadPendingHistoriesUsecase({
    required RecorderFileLoader recorderFileLoader,
    required RecordedFileUtil recordedFileUtil,
    required AuthRepository authRepository,
    required HistoryRepository historyRepository,
  })  : _recorderFileLoader = recorderFileLoader,
        _recordedFileUtil = recordedFileUtil,
        _authRepository = authRepository,
        _historyRepository = historyRepository;

  final RecorderFileLoader _recorderFileLoader;
  final RecordedFileUtil _recordedFileUtil;
  final AuthRepository _authRepository;
  final HistoryRepository _historyRepository;

  Future<Either<Exception, void>> call({
    required String userId,
  }) async {
    try {
      final user = _authRepository.getUserOrNullByUserId(userId) ??
          (throw const NotFoundUserException(message: 'User not found'));

      final histories = await _historyRepository.getPendingHistories();

      final results = await Future.wait(
        histories.map(
          (history) => (history is VoidingHistory && !history.isManual
                  ? _uploadAutoVoidingHistory(user: user, history: history)
                  : _uploadHistory(user: user, history: history))
              .catchError((_) => false),
        ),
      );

      if (results.contains(false)) {
        throw Exception('any history upload failed');
      }

      return const Right(null);
    } catch (e) {
      return Left(e is Exception ? e : Exception(e.toString()));
    }
  }

  Future<bool> _uploadHistory({
    required User user,
    required History history,
  }) async {
    await _historyRepository.uploadHistory(userId: user.id, history: history);

    await _historyRepository.saveHistory(history.setStatus(HistoryStatus.done));

    return true;
  }

  Future<bool> _uploadAutoVoidingHistory({
    required User user,
    required VoidingHistory history,
  }) async {
    final file = _recorderFileLoader.getFile(history.recordTime);
    final isFileNotExist = !file.existsSync();

    // TODO(eden): 파일이 없을때 로우를 삭제할지 그냥 냅둘지 정해야함
    if (isFileNotExist) {
      return false;
    }

    await _historyRepository.uploadVoidingSoundFile(
      fileName: _recordedFileUtil.generateFileName(file: file, user: user),
      file: file,
    );

    await _historyRepository.saveHistory(history.setStatus(HistoryStatus.processing));

    return true;
  }
}
