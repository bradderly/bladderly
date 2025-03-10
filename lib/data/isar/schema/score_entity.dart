import 'package:bladderly/domain/model/score_status.dart';
import 'package:isar/isar.dart';

part 'score_entity.g.dart';

@collection
class ScoreEntity {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true, composite: [CompositeIndex('date')])
  @Name('score_name')
  late String name;

  @Name('score_date')
  late DateTime date;

  @Name('score_value')
  late List<int> scorevalue;

  @Name('status')
  @Enumerated(EnumType.name)
  late ScoreStatus status;

  void setId(int? id) => this.id = id ?? this.id;
}
