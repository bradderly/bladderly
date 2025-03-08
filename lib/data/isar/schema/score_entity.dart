import 'package:bladderly/domain/model/score_status.dart';
import 'package:isar/isar.dart';

part 'score_entity.g.dart';

@collection
class ScoreEntity {
  Id id = Isar.autoIncrement;

  @Name('score_date')
  late String date;

  @Name('score_name')
  late String name;

  @Name('total_score')
  late int totalScore;

  @Name('score_value')
  late List<int> scorevalue;

  @Name('status')
  @Enumerated(EnumType.name)
  late ScoreStatus status;

  void setId(int? id) => this.id = id ?? this.id;
}
