import 'package:bladderly/domain/model/score_status.dart';
import 'package:bladderly/domain/model/score_type.dart';
import 'package:equatable/equatable.dart';

class Score extends Equatable {
  const Score({
    required this.date,
    required this.type,
    required this.status,
    required this.answers,
  });

  final DateTime date;
  final ScoreType type;
  final ScoreStatus status;
  final List<int> answers;

  int getScoreByAnswerIndex(int index) {
    if (type == ScoreType.IPSS && index == 7) return 0;

    return answers[index];
  }

  int? get qolAnswer {
    return type == ScoreType.IPSS ? answers[7] : null;
  }

  int get totalScore {
    return List.generate(answers.length, getScoreByAnswerIndex).reduce((a, b) => a + b);
  }

  Score setStatus(ScoreStatus status) {
    return Score(
      date: date,
      type: type,
      status: status,
      answers: answers,
    );
  }

  @override
  List<Object?> get props => [
        date,
        type,
        status,
        answers,
      ];
}
