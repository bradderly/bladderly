import 'package:bladderly/domain/model/history.dart';
import 'package:bladderly/domain/model/history_status.dart';
import 'package:bladderly/domain/model/leakage_volume.dart';
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/feature/diary/diary/model/diary_history_type_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DiaryHistoryModel extends Equatable {
  const DiaryHistoryModel({
    required this.id,
    required this.type,
    required DateTime recordTime,
    required this.isNocturia,
    required int? recordVolume,
    required this.recordUrgency,
    required this.leakageVolume,
    required this.beverageType,
    required this.isProcessing,
  })  : _recordTime = recordTime,
        _recordVolume = recordVolume;

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
          isProcessing: history.status == HistoryStatus.processing,
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
          isProcessing: false,
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
          isProcessing: false,
        ),
    };
  }

  final int id;
  final DiaryHistoryTypeModel type;
  final DateTime _recordTime;
  final bool isNocturia;
  final int? _recordVolume;
  final int? recordUrgency;
  final String? leakageVolume;
  final String? beverageType;
  final bool isProcessing;

  String getRecordTime(BuildContext context) {
    final hourMinute = DateFormat('hh:mm').format(_recordTime);
    final meridiem = _recordTime.hour < 12 ? 'am' : 'pm';
    return '$hourMinute ${meridiem.tr(context)}';
  }

  String getRecordVolume(BuildContext context) {
    if (type == DiaryHistoryTypeModel.leakage) return '';

    return _recordVolume == null ? 'N/A' : '${context.unitValue(_recordVolume)}${context.unitName}';
  }

  @override
  List<Object?> get props => [
        id,
        type,
        _recordTime,
        isNocturia,
        _recordVolume,
        recordUrgency,
        leakageVolume,
        beverageType,
        isProcessing,
      ];
}
