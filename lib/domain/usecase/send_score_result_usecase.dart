// Package imports:
import 'package:bladderly/domain/model/score.dart';
import 'package:bladderly/domain/model/score_status.dart';
import 'package:bladderly/domain/model/score_type.dart';
import 'package:bladderly/domain/repository/score_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

// Project imports:

@lazySingleton
class SendScoreResultUsecase {
  const SendScoreResultUsecase({
    required ScoreRepository scoreRepository,
  }) : _scoreRepository = scoreRepository;

  final ScoreRepository _scoreRepository;

  Future<Either<Exception, void>> call({
    required String userId,
    required ScoreType scoreName,
    required DateTime scoreDate,
    required List<int> scoreValue,
  }) async {
    try {
      final result = await _scoreRepository.uploadScoreResult(
        Score(
          date: scoreDate,
          type: scoreName,
          status: ScoreStatus.pending,
          totalScore: scoreValue.reduce((value, element) => value + element),
          values: scoreValue,
        ),
        userId,
      );
      return Right(result);
    } on Exception catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
