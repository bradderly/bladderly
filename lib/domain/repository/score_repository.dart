// Dart imports:
// Project imports:

import 'package:bladderly/domain/model/score.dart';
import 'package:bladderly/domain/model/scores.dart';

abstract class ScoreRepository {
  const ScoreRepository._();

  Future<void> uploadScore(Score score);

  Stream<List<Score>> get scoresStream;

  Future<Scores> saveScores(Scores scores);

  Future<Scores> getAllScoreHistoriesFromServer(String userId);

  Stream<Scores> getScoresStream();
}
