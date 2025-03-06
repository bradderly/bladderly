// Dart imports:
// Project imports:

import 'package:bladderly/domain/model/score.dart';

abstract class ScoreRepository {
  Future<List<Score>> getScoreHistoriesFromServer(String userId);
}
