// Dart imports:
// Project imports:

import 'package:bladderly/domain/model/score.dart';
import 'package:bladderly/domain/model/scores.dart';

abstract class ScoreRepository {
  const ScoreRepository._();

  Future<void> uploadScoreResult({
    required String userId,
    required Score score,
  });

  Future<void> saveScores(Scores scores);

  Future<Scores> getAllScoreHistoriesFromServer(String userId);

  Stream<Scores> getScoresStream();

  Future<Score> saveScore(Score score);
}
