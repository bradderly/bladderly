// Project imports:
import 'package:bladderly/data/api/model/swagger_json.models.swagger.dart';
import 'package:bladderly/data/isar/schema/score_entity.dart';
import 'package:bladderly/domain/model/score.dart';
import 'package:bladderly/domain/model/score_status.dart';
import 'package:bladderly/domain/model/score_type.dart';

class ScoreMapper {
  const ScoreMapper._();

  static Score? fromGetAllScoreResponseList(GetAllScoreResponseList score) {
    return Score(
      date: DateTime.parse(score.scoreDate!.replaceFirst('-', 'T')),
      type: ScoreType.values.byName(score.scoreName!),
      answers: score.scoreValue ?? [],
      status: ScoreStatus.done,
    );
  }

  static ScoreEntity toScoreEntity(Score score) {
    return ScoreEntity()
      ..date = score.date
      ..name = score.type.name
      ..scorevalue = score.answers
      ..status = score.status;
  }

  static Score fromScoreEntity(ScoreEntity entity) {
    return Score(
      date: entity.date,
      type: ScoreType.values.byName(entity.name),
      answers: entity.scorevalue,
      status: entity.status,
    );
  }
}
