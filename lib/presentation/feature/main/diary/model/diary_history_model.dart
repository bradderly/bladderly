import 'package:bradderly/domain/model/history.dart';
import 'package:bradderly/domain/model/leakage_volume.dart';
import 'package:bradderly/presentation/common/extension/string_extension.dart';
import 'package:bradderly/presentation/feature/main/diary/model/diary_history_type_model.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class DiaryHistoryModel extends Equatable {
  const DiaryHistoryModel({
    required this.id,
    required this.type,
    required DateTime recordTime,
    required this.isNocturia,
    required this.recordVolume,
    required this.recordUrgency,
    required this.leakageVolume,
    required this.beverageType,
  }) : _recordTime = recordTime;

  factory DiaryHistoryModel.fromDomain(History history) {
    return switch (history) {
      VoidingHistory() => DiaryHistoryModel(
          id: history.id!,
          type: DiaryHistoryTypeModel.voiding,
          recordTime: history.recordTime,
          recordVolume: history.recordVolume,
          isNocturia: history.isNocutria,
          recordUrgency: history.recordUrgency,
          leakageVolume: switch (history.leakageVolume) {
            LeakageVolume.Small => 'S',
            LeakageVolume.Medium => 'M',
            LeakageVolume.Large => 'L',
            null => '',
          },
          beverageType: null,
        ),
      IntakeHistory() => DiaryHistoryModel(
          id: history.id!,
          type: DiaryHistoryTypeModel.intake,
          recordTime: history.recordTime,
          isNocturia: false,
          recordVolume: history.recordVolume,
          recordUrgency: null,
          leakageVolume: null,
          beverageType: history.beverageType,
        ),
      LeakageHistory() => DiaryHistoryModel(
          id: history.id!,
          type: DiaryHistoryTypeModel.leakage,
          recordTime: history.recordTime,
          isNocturia: false,
          recordVolume: null,
          recordUrgency: null,
          leakageVolume: switch (history.leakageVolume) {
            LeakageVolume.Small => 'S',
            LeakageVolume.Medium => 'M',
            LeakageVolume.Large => 'L',
          },
          beverageType: null,
        ),
    };
  }

  final int id;
  final DiaryHistoryTypeModel type;
  final DateTime _recordTime;
  final bool isNocturia;
  final int? recordVolume;
  final int? recordUrgency;
  final String? leakageVolume;
  final String? beverageType;

  String get recordTime {
    final hourMinute = DateFormat('hh:mm').format(_recordTime);
    final meridiem = _recordTime.hour < 12 ? 'am' : 'pm';
    return '$hourMinute ${meridiem.tr}';
  }

  @override
  List<Object?> get props => [
        id,
        type,
        _recordTime,
        recordVolume,
        recordUrgency,
        leakageVolume,
        beverageType,
      ];
}
