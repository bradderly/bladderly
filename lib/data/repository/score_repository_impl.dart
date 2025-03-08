// Dart imports:
import 'dart:io';
// Project imports:
import 'package:bladderly/data/api/client/api_client.dart';
import 'package:bladderly/data/isar/isar_client.dart';
import 'package:bladderly/data/isar/schema/score_entity.dart';
import 'package:bladderly/data/mapper/score_mapper.dart';
import 'package:bladderly/domain/model/score.dart';
import 'package:bladderly/domain/model/scores.dart';
import 'package:bladderly/domain/repository/score_repository.dart';
// Package imports:
import 'package:injectable/injectable.dart';
import 'package:rxdart/subjects.dart';

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
    print('5555');
    return _isarClient
        .saveScores(scores)
        .then((histories) => Scores(list: histories.map(ScoreMapper.fromScoreEntity).toList()));
  }

  @override
  Future<void> uploadScore(Score score) {
    // TODO: implement uploadScorse
    throw UnimplementedError();
  }

  @override
  Future<Scores> getAllScoreHistoriesFromServer(String userId) async {
    final response = await _apiClient.getAllRecords(userId: userId).then((response) => response.body!);

    final scores = response.scores ?? [];

    return Scores(
      list: scores.map(ScoreMapper.fromGetAllResultResponse$Scores$Item).whereType<Score>().toList(),
    );
  }

  @override
  Score saveScore(Scores<Score> scores) {
    // TODO: implement saveScore
    throw UnimplementedError();
  }

  @override
  Stream<Scores<Score>> getScoresStream() {
    return _isarClient.getScoresStream().map(
          (scoreEntities) => Scores(
            list: scoreEntities.map(ScoreMapper.fromScoreEntity).toList(),
          ),
        );
  }
}
