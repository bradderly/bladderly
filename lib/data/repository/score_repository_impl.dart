// Dart imports:
import 'dart:io';

// Project imports:
import 'package:bladderly/data/api/client/api_client.dart';
import 'package:bladderly/data/isar/isar_client.dart';
import 'package:bladderly/domain/model/score.dart';
import 'package:bladderly/domain/repository/score_repository.dart';
// Package imports:
import 'package:injectable/injectable.dart';

@LazySingleton(as: ScoreRepository)
class ScoreRepositoryImpl implements ScoreRepository {
  const ScoreRepositoryImpl({
    required IsarClient isarClient,
    required ApiClient apiClient,
  })  : _isarClient = isarClient,
        _apiClient = apiClient;

  final IsarClient _isarClient;
  final ApiClient _apiClient;

  @override
  Future<List<Score>> getScoreHistoriesFromServer(String userId) async {
    print('LOGTAG API Request ${userId}'); // API 응답 데이터 출력
    final response = await _apiClient.getAllRecords(userId: userId);

    print('LOGTAG 1212');
    print('LOGTAG API Response Body: ${response.body}'); // API 응답 데이터 출력

    final scores = response.body!.scores ?? [];

    print('LOGTAG Parsed Score: $scores'); // scores 리스트 출력
    /*
    final response = await _apiClient.getAllRecords(userId: userId).then((response) => response.body!);     
    final scores = response.scores ?? [];
*/
    final scoresScore = <Score>[];

    for (var i = 0; i < scores.length; i++) {
      scoresScore.add(
        Score.fromValues(
          scoreDate: scores[i].scoreDate?.toString(),
          scoreName: scores[i].scoreName?.toString(),
          totalScore: scores[i].totalScore?.toString(),
          scoreValue: scores[i].scoreValue?.map((e) => e.toString()).toList() ?? [],
        ),
      );
    }

    return scoresScore;
  }
}
