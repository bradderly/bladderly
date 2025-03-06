// Dart imports:
// Project imports:

import 'package:bladderly/domain/model/score.dart';

abstract class ScoreRepository {
  const ScoreRepository._();

  Score saveScore(Score score);

  Future<void> uploadScore(Score score);

  Stream<List<Score>> getScoresStream();
}
