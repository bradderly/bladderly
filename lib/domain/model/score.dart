import 'package:bladderly/domain/model/score_status.dart';
import 'package:bladderly/domain/model/score_type.dart';
import 'package:equatable/equatable.dart';

class Score extends Equatable {
  const Score({
    required this.date,
    required this.type,
    required this.status,
    required this.totalScore,
    required this.values,
  });

  final DateTime date;
  final ScoreType type;
  final ScoreStatus status;
  final int totalScore;
  final List<int> values;

  @override
  List<Object?> get props => [
        date,
        type,
        status,
        totalScore,
        values,
      ];
}
