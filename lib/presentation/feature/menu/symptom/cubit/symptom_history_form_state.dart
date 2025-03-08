part of 'symptom_history_form_cubit.dart';

class SymptomHistoryFormState extends Equatable {
  const SymptomHistoryFormState({
    this.scores = const Scores.empty(), // 빈 값으로 초기화
  });

  final Scores scores;

  SymptomHistoryFormState copyWith({
    Scores? scores,
  }) {
    return SymptomHistoryFormState(
      scores: scores ?? this.scores,
    );
  }

  @override
  List<Object> get props => [scores];
}
