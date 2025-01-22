import 'package:bradderly/presentation/feature/diary/diary/model/diary_history_type_model.dart';
import 'package:equatable/equatable.dart';

class DiaryHistoryModel extends Equatable {
  const DiaryHistoryModel({
    required this.id,
    required this.type,
    required this.recordTime,
    required this.recordVolume,
    required this.recordUrgency,
    required this.leakageVolume,
    required this.beverageType,
  });

  final int id;
  final DiaryHistoryTypeModel type;
  final DateTime recordTime;
  final int? recordVolume;
  final int? recordUrgency;
  final String? leakageVolume;
  final String? beverageType;

  @override
  List<Object?> get props => [
        id,
        type,
        recordTime,
        recordVolume,
        recordUrgency,
        leakageVolume,
        beverageType,
      ];
}
