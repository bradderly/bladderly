// Dart imports:
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
  Score saveScore(Score score) {
    // TODO: implement saveScore
    throw UnimplementedError();
  }

  @override
  Future<void> uploadScore(Score score) {
    // TODO: implement uploadScore
    throw UnimplementedError();
  }

  @override
  Stream<List<Score>> getScoresStream() {
    // TODO: implement getScoresStream
    throw UnimplementedError();
  }
}
