import 'package:equatable/equatable.dart';

sealed class Score extends Equatable {
  const Score._({
    required this.scoreDate,
    required this.scoreName,
    required this.totalScore,
    required this.scoreValue,
  });

  /// 종류
  final String? scoreDate;
  final String? scoreName;
  final String? totalScore;
  final List<Object> scoreValue;

  @override
  List<Object?> get props => [
        scoreDate,
        scoreName,
        totalScore,
        scoreValue,
      ];

  static Score fromValues({
    String? scoreDate,
    String? scoreName,
    String? totalScore,
    List<Object>? scoreValue,
  }) {
    return ConcreteScore(
      scoreDate: scoreDate,
      scoreName: scoreName,
      totalScore: totalScore,
      scoreValue: scoreValue?.map((e) => e.toString()).toList() ?? [],
    );
  }
}

class ConcreteScore extends Score {
  const ConcreteScore({
    super.scoreDate,
    super.scoreName,
    super.totalScore,
    required super.scoreValue,
  }) : super._();
}
