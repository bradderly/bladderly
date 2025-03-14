part of 'symptom_scores_form_cubit.dart';

class SymptomScoresFormState extends Equatable {
  const SymptomScoresFormState(this.scores);

  final Scores scores;

  @override
  List<Object> get props => [
        scores,
      ];
}
