import 'package:bladderly/domain/model/score_type.dart';
import 'package:bladderly/presentation/feature/menu/symptom/model/symptom_survey_questions_model.dart';
import 'package:equatable/equatable.dart';

class SymptomSurveyModel extends Equatable {
  const SymptomSurveyModel._({
    required this.title,
    required this.subtitle,
    required this.scoreType,
    required Duration duration,
    required this.description,
    required this.questions,
  }) : _duration = duration;

  static final _ipss = SymptomSurveyModel._(
    title: 'IPSS',
    subtitle: 'International Prostate Symptom Score',
    scoreType: ScoreType.IPSS,
    duration: const Duration(minutes: 2),
    description: 'IPSS Desc',
    questions: SymptomSurveyQuestionsModel.ipssQ(),
  );

  static final _oabss = SymptomSurveyModel._(
    title: 'OABSS',
    subtitle: 'Overactive Bladder Symptom Score',
    scoreType: ScoreType.OABSS,
    duration: const Duration(minutes: 1),
    description: 'OABSS Desc',
    questions: SymptomSurveyQuestionsModel.oabss(),
  );

  static SymptomSurveyModel getByScoreType(ScoreType type) {
    return switch (type) {
      ScoreType.IPSS => _ipss,
      ScoreType.OABSS => _oabss,
    };
  }

  final String title;
  final String subtitle;
  final ScoreType scoreType;
  final Duration _duration;
  final String description;
  final SymptomSurveyQuestionsModel questions;

  int get duration => _duration.inMinutes;

  int get questionCount => questions.length;

  @override
  List<Object?> get props => [
        title,
        subtitle,
        scoreType,
        _duration,
        description,
        questions,
      ];
}
