import 'package:bradderly/domain/model/history_status.dart';
import 'package:bradderly/domain/model/leakage_volume.dart';
import 'package:equatable/equatable.dart';

sealed class History extends Equatable {
  const History({
    required this.id,
    required this.hashId,
    required this.recordTime,
    required this.memo,
    required this.status,
  });

  final int? id;

  final String hashId;

  /// 기록일
  final DateTime recordTime;

  /// 메모
  final String? memo;

  final HistoryStatus status;

  History setId(int id);

  @override
  List<Object?> get props => [
        id,
        recordTime,
        memo,
        status,
      ];
}

class VoidingHistory extends History {
  const VoidingHistory({
    required super.id,
    required super.hashId,
    required super.recordTime,
    required super.memo,
    required super.status,
    required this.recordVolume,
    required this.recordUrgency,
    required this.isManual,
    required this.isNocutria,
    required this.isLeakage,
    required this.leakageVolume,
  });

  /// 배뇨량
  final int recordVolume;

  /// 마려웠던 정도
  final int recordUrgency;

  /// 수동 입력 여부
  final bool isManual;

  /// 수면 중 화장실에 가려고 꺳는지 여부
  final bool isNocutria;

  /// 요실금 발생 여부
  final bool isLeakage;

  /// 요실금 발생 양
  final LeakageVolume? leakageVolume;

  @override
  VoidingHistory setId(int id) {
    return VoidingHistory(
      id: id,
      hashId: hashId,
      recordTime: recordTime,
      memo: memo,
      status: status,
      recordVolume: recordVolume,
      recordUrgency: recordUrgency,
      isManual: isManual,
      isNocutria: isNocutria,
      isLeakage: isLeakage,
      leakageVolume: leakageVolume,
    );
  }

  @override
  List<Object?> get props => [
        ...super.props,
        recordVolume,
        recordUrgency,
        isManual,
        isNocutria,
        isLeakage,
        leakageVolume,
      ];
}

class IntakeHistory extends History {
  const IntakeHistory({
    required super.id,
    required super.hashId,
    required super.recordTime,
    required super.memo,
    required super.status,
    required this.beverageType,
    required this.recordVolume,
  });

  /// 섭취 종류
  final String beverageType;

  /// 섭취량
  final int recordVolume;

  @override
  IntakeHistory setId(int id) {
    return IntakeHistory(
      id: id,
      hashId: hashId,
      recordTime: recordTime,
      memo: memo,
      status: status,
      beverageType: beverageType,
      recordVolume: recordVolume,
    );
  }

  @override
  List<Object?> get props => [
        ...super.props,
        beverageType,
        recordVolume,
      ];
}

class LeakageHistory extends History {
  const LeakageHistory({
    required super.id,
    required super.hashId,
    required super.recordTime,
    required super.memo,
    required super.status,
    required this.leakageVolume,
  });

  final LeakageVolume leakageVolume;

  @override
  LeakageHistory setId(int id) {
    return LeakageHistory(
      id: id,
      hashId: hashId,
      recordTime: recordTime,
      memo: memo,
      status: status,
      leakageVolume: leakageVolume,
    );
  }

  @override
  List<Object?> get props => [
        ...super.props,
        leakageVolume,
      ];
}
