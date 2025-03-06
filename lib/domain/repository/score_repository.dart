// Dart imports:
// Project imports:

import 'package:bladderly/domain/model/score.dart';

abstract class ScoreRepository {
  Score saveScore(Score score);

  Future<void> uploadScore(Score score);

  Stream<List<Score>> getScoresStream();
}
