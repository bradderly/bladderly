// Package imports:
// Project imports:
import 'package:objectbox/objectbox.dart';

@Entity()
class HistoryEntity {
  @Id()
  int id = 0;

  @Unique(onConflict: ConflictStrategy.replace)
  late DateTime recordTime;

  bool? isIntake;

  int? recordUrgency;

  bool? isManual;

  late double recordVolume;

  bool? isNocturia;

  bool? isLeakage;

  String? leakageVolume;

  String? beverageType;

  String? leakageMemo;

  late String status;

  DateTime? deletedAt;

  void setId(int? id) => this.id = id ?? this.id;
}
