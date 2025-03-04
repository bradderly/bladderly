// Flutter imports:
// Project imports:
import 'package:bladderly/domain/model/history.dart';
import 'package:bladderly/domain/model/history_status.dart';
import 'package:bladderly/domain/model/leakage_volume.dart';
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/feature/diary/diary/model/diary_history_status_model.dart';
import 'package:bladderly/presentation/feature/diary/diary/model/diary_history_type_model.dart';
// Package imports:
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DiaryHistoryModel extends Equatable {
  const DiaryHistoryModel({
    required this.id,
    required this.type,
    required this.status,
    required DateTime recordTime,
    required this.isNocturia,
    required int? recordVolume,
    required this.recordUrgency,
    required this.leakageVolume,
    required this.beverageType,
  })  : _recordTime = recordTime,
        _recordVolume = recordVolume;

  factory DiaryHistoryModel.fromDomain(History history) {
    final statusModel = switch (history.status) {
      HistoryStatus.processing => DiaryHistoryStatusModel.processing,
      HistoryStatus.failed => DiaryHistoryStatusModel.failed,
      _ => DiaryHistoryStatusModel.done,
    };
    return switch (history) {
      VoidingHistory() => DiaryHistoryModel(
          id: history.id!,
          type: DiaryHistoryTypeModel.voiding,
          status: statusModel,
          recordTime: history.recordTime,
          recordVolume: history.recordVolume,
          isNocturia: history.isNocturia,
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
          status: statusModel,
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
          status: statusModel,
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
  final DiaryHistoryStatusModel status;
  final DateTime _recordTime;
  final bool isNocturia;
  final int? _recordVolume;
  final int? recordUrgency;
  final String? leakageVolume;
  final String? beverageType;

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
        status,
        _recordTime,
        isNocturia,
        _recordVolume,
        recordUrgency,
        leakageVolume,
        beverageType,
      ];
}
