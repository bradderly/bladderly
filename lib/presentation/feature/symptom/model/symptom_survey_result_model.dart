import 'dart:ui';

import 'package:bladderly/domain/model/score_type.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';

enum SymptomSurveyResultModel {
  noSymptom(
    text: 'No symptom',
    description:
        'Your score currently indicates no symptoms. Continue to take IPSS questionnaire monthly to monitor any changes.',
    ipssMin: 0,
    ipssMax: 0,
    oabssMin: 0,
    oabssMax: 0,
  ),
  mild(
    text: 'Mild',
    description:
        'Your score indicates mild prostate symptoms. Ongoing observation or lifestyle changes may be necessary. Respond regularly each month to track results.',
    ipssMin: 1,
    ipssMax: 7,
    oabssMin: 0,
    oabssMax: 5,
  ),
  moderate(
    text: 'Moderate',
    description:
        'Your score indicates moderate prostate symptoms that do not significantly impact your quality of life. If discomfort occurs, medication or procedures may be required.',
    ipssMin: 8,
    ipssMax: 19,
    oabssMin: 6,
    oabssMax: 11,
  ),
  severe(
    text: 'Severe',
    description:
        'Your score indicates severe prostate symptoms with noticeable discomfort. It is recommended to seek medical assistance. Medication or procedures may be necessary.',
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

  factory SymptomSurveyResultModel.fromTotalScore({
    required ScoreType surveyType,
    required int totalScore,
  }) {
    for (final model in SymptomSurveyResultModel.values) {
      final min = surveyType == ScoreType.IPSS ? model.ipssMin : model.oabssMin;
      final max = surveyType == ScoreType.IPSS ? model.ipssMax : model.oabssMax;

      if (totalScore >= min && totalScore <= max) {
        return model;
      }
    }

    throw ArgumentError('Invalid score: $totalScore');
  }

  final String text;
  final String description;
  final int ipssMin;
  final int ipssMax;
  final int oabssMin;
  final int oabssMax;

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
