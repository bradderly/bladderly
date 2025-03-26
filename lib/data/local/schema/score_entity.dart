import 'package:objectbox/objectbox.dart';

@Entity()
class ScoreEntity {
  @Id()
  int id = 0;

  late String name;

  late DateTime date;

  @Unique(onConflict: ConflictStrategy.replace)
  late String uniqueKey;

  late List<int> scorevalue;

  late String status;

  void setId(int? id) => this.id = id ?? this.id;
}
