import 'package:equatable/equatable.dart';

class Membership extends Equatable {
  const Membership({
    required this.name,
    required this.startAt,
    required this.endAt,
    required this.renewAt,
  });

  /// 구매한 플랜 이름
  final String name;

  /// 플랜 시작일
  final DateTime startAt;

  /// 플랜 종료일
  final DateTime endAt;

  /// 플랜 갱신일
  final DateTime? renewAt;

  @override
  List<Object?> get props => [
        name,
        startAt,
        endAt,
        renewAt,
      ];
}
