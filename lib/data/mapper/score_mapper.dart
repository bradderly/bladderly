// Project imports:
import 'package:bladderly/data/api/model/swagger_json.models.swagger.dart';
import 'package:bladderly/data/isar/schema/score_entity.dart';
import 'package:bladderly/domain/model/score.dart';
import 'package:bladderly/domain/model/score_status.dart';
import 'package:bladderly/domain/model/score_type.dart';
import 'package:flutter/foundation.dart';

class ScoreMapper {
  const ScoreMapper._();

  static Score? fromGetAllResultResponse$Scores$Item(GetAllResultResponse$Scores$Item score) {
    try {
      const status = ScoreStatus.done;
      return Score(
        date: DateTime.parse(score.scoreDate!.split('-')[0]),
        type: ScoreType.values.firstWhere((e) => e.toString() == 'ScoreType.${score.scoreName}'),
        totalScore: score.totalScore ?? 0,
        values: score.scoreValue?.map((e) => e as int).toList() ?? [],
        status: status,
      );
    } catch (e) {
      if (kDebugMode) {
        print('error : $e');
      }
      return null;
    }
  }

  static ScoreEntity toScoreEntity(Score score) {
    return ScoreEntity()
      ..date = score.date.toIso8601String()
      ..name = score.type.name
      ..totalScore = score.totalScore
      ..scorevalue = score.values
      ..status = score.status;
  }

  static Score fromScoreEntity(ScoreEntity entity) {
    return Score(
      date: DateTime.parse(entity.date),
      type: ScoreType.values.byName(entity.name),
      totalScore: entity.totalScore,
      values: entity.scorevalue,
      status: entity.status,
    );
  }
}
