import 'package:bladderly/domain/model/scores.dart';
import 'package:bladderly/domain/repository/score_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SaveScoreUsecase {
  const SaveScoreUsecase({
    required ScoreRepository scoreRepository,
  }) : _scoreRepository = scoreRepository;

  // 사용 시나리오
  // 로컬 디비에 있는 스코어들을 구독하는 스트림을 가져온다.

  final ScoreRepository _scoreRepository;

  Future<Either<Exception, void>> call({
    required Scores scores,
  }) async {
    try {
      await _scoreRepository.saveScores(scores);
      print('SaveScoreUsecase call2');
      return const Right(true);
    } catch (e) {
      return Left(e is Exception ? e : Exception(e.toString()));
    }
  }
}
