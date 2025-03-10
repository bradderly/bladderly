// Package imports:
import 'package:bladderly/core/network_checker/network_checker.dart';
import 'package:bladderly/domain/model/score.dart';
import 'package:bladderly/domain/model/score_status.dart';
import 'package:bladderly/domain/model/score_type.dart';
import 'package:bladderly/domain/repository/score_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SendScoreResultUsecase {
  const SendScoreResultUsecase({
    required ScoreRepository scoreRepository,
    required NetworkChecker networkChecker,
  })  : _scoreRepository = scoreRepository,
        _networkChecker = networkChecker;

  final ScoreRepository _scoreRepository;
  final NetworkChecker _networkChecker;

  Future<Either<Exception, Score>> call({
    required String userId,
    required ScoreType scoreType,
    required List<int> scoreValue,
  }) async {
    try {
      final pendingScore = await _scoreRepository.saveScore(
        Score(
          date: DateTime.now(),
          type: scoreType,
          status: ScoreStatus.pending,
          answers: scoreValue,
        ),
      );

      final isNetworkConnected = await _networkChecker.isConnected;

      if (!isNetworkConnected) return Right(pendingScore);

      await _scoreRepository.uploadScoreResult(
        userId: userId,
        score: pendingScore,
      );

      final doneScore = await _scoreRepository.saveScore(pendingScore.setStatus(ScoreStatus.done));

      return Right(doneScore);
    } on Exception catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
