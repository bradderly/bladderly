import 'dart:ui';
import 'package:bladderly/domain/model/score_type.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';

enum SymptomSurveyResultModel {
  noSymptom(
    text: 'No Symptom',
    description:
        'Your score currently indicates no symptoms. Continue to take the questionnaire monthly to monitor any changes.',
    ipssMin: 0,
    ipssMax: 0,
    oabssMin: 0,
    oabssMax: 0,
  ),
  mild(
    text: 'Mild',
    description: 'Your score indicates mild symptoms that do not significantly impact your quality of life.',
    ipssMin: 1,
    ipssMax: 7,
    oabssMin: 0,
    oabssMax: 5,
  ),
  moderate(
    text: 'Moderate',
    description:
        'Your score indicates moderate symptoms with noticeable discomfort. Medical assistance may be necessary.',
    ipssMin: 8,
    ipssMax: 19,
    oabssMin: 6,
    oabssMax: 11,
  ),
  severe(
    text: 'Severe',
    description:
        'Your score indicates severe symptoms with significant discomfort. Seek medical assistance immediately.',
    ipssMin: 20,
    ipssMax: 35,
    oabssMin: 12,
    oabssMax: 15,
  );

  const SymptomSurveyResultModel({
    required this.text,
    required this.description,
    required this.ipssMin,
    required this.ipssMax,
    required this.oabssMin,
    required this.oabssMax,
  });

  final String text;
  final String description;
  final int ipssMin;
  final int ipssMax;
  final int oabssMin;
  final int oabssMax;

  factory SymptomSurveyResultModel.fromTotalScore(int totalScore, ScoreType surveyType) {
    for (final model in SymptomSurveyResultModel.values) {
      final min = surveyType == ScoreType.IPSS ? model.ipssMin : model.oabssMin;
      final max = surveyType == ScoreType.IPSS ? model.ipssMax : model.oabssMax;

      if (totalScore >= min && totalScore <= max) {
        return model;
      }
    }
    throw ArgumentError('Invalid score: $totalScore');
  }

  SvgGenImage get icon {
    switch (this) {
      case noSymptom:
        return Assets.icon.icSymptomFace1;
      case mild:
        return Assets.icon.icSymptomFace2;
      case moderate:
        return Assets.icon.icSymptomFace3;
      case severe:
        return Assets.icon.icSymptomFace4;
    }
  }

  Color get color {
    switch (this) {
      case noSymptom:
        return const Color(0xFF94A22F);
      case mild:
        return const Color(0xFF94A22F);
      case moderate:
        return const Color(0xFFFF8D38);
      case severe:
        return const Color(0xFFFF6442);
    }
  }
}
