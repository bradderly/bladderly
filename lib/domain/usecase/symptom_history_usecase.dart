// Package imports:

// Project imports:
import 'package:bladderly/domain/model/score.dart';
import 'package:bladderly/domain/repository/score_repository.dart';
// Package imports:
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SymptomHistoryUsecase {
  const SymptomHistoryUsecase({
    required ScoreRepository scoreRepository,
  }) : _scoreRepository = scoreRepository;

  final ScoreRepository _scoreRepository;

  Future<Either<Exception, List<Score>>> call({
    required String userId,
  }) async {
    try {
      print('LOGTAG 0000  $userId');
      final scores = await _scoreRepository.getScoreHistoriesFromServer(userId);
      print('LOGTAG 222222');
      return Right(scores);
    } catch (e) {
      return Left(e is Exception ? e : Exception(e.toString()));
    }
  }
}
