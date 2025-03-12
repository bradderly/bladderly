// Dart imports:
// Project imports:
import 'package:bladderly/data/api/client/api_client.dart';
import 'package:bladderly/data/api/model/swagger_json.models.swagger.dart';
import 'package:bladderly/data/isar/isar_client.dart';
import 'package:bladderly/data/mapper/score_mapper.dart';
import 'package:bladderly/domain/model/score.dart';
import 'package:bladderly/domain/model/scores.dart';
import 'package:bladderly/domain/repository/score_repository.dart';
// Package imports:
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

@LazySingleton(as: ScoreRepository)
class ScoreRepositoryImpl implements ScoreRepository {
  ScoreRepositoryImpl({
    required IsarClient isarClient,
    required ApiClient apiClient,
  })  : _isarClient = isarClient,
        _apiClient = apiClient;

  final IsarClient _isarClient;
  final ApiClient _apiClient;

  @override
  Future<void> saveScores(Scores scores) {
    return _isarClient
        .saveScores(scores.map(ScoreMapper.toScoreEntity).toList())
        .then((histories) => Scores(list: histories.map(ScoreMapper.fromScoreEntity).toList()));
  }

  @override
  Future<void> uploadScoreResult({
    required String userId,
    required Score score,
  }) {
    return _apiClient.saveScore(
      request: SaveSurveyRequest(
        userId: userId,
        scoreName: score.type.name,
        scoreDate: DateFormat('yyyyMMdd-HHmmss').format(score.date),
        scoreValue: score.answers,
      ),
    );
  }

  @override
  Future<Scores> getAllScoreHistoriesFromServer(String userId) async {
    final response = await _apiClient.getAllRecords(userId: userId).then((response) => response.body!);

    final scores = response.scores ?? [];

    return Scores(
      list: scores.map(ScoreMapper.fromGetAllScoreResponseList).whereType<Score>().toList(),
    );
  }

  @override
  Stream<Scores> getScoresStream() {
    return _isarClient
        .getScoresStream()
        .map((scoreEntities) => Scores(list: scoreEntities.map(ScoreMapper.fromScoreEntity).toList()));
  }

  @override
  Future<Score> saveScore(Score score) {
    return _isarClient.saveScore(ScoreMapper.toScoreEntity(score)).then(ScoreMapper.fromScoreEntity);
  }
}
