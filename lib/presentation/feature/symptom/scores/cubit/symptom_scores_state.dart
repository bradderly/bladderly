part of 'symptom_scores_cubit.dart';

class SymptomScoresState extends Equatable {
  const SymptomScoresState({
    this.scores = const Scores.empty(),
    this.isExpandedIpss = false,
    this.isExpandedOabss = false,
  });

  final Scores scores;
  final bool isExpandedIpss;
  final bool isExpandedOabss;

  SymptomScoresState copyWith({
    Scores? scores,
    bool? isExpandedIpss,
    bool? isExpandedOabss,
  }) {
    return SymptomScoresState(
      scores: scores ?? this.scores,
      isExpandedIpss: isExpandedIpss ?? this.isExpandedIpss,
      isExpandedOabss: isExpandedOabss ?? this.isExpandedOabss,
    );
  }

  @override
  List<Object> get props => [
        scores,
        isExpandedIpss,
        isExpandedOabss,
      ];
}
