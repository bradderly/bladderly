part of 'symptom_history_form_cubit.dart';

class SymptomHistoryFormState extends Equatable {
  const SymptomHistoryFormState(this.scores);

  final Scores scores;

  @override
  List<Object> get props => [
        scores,
      ];
}
