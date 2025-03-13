import 'dart:ui';

import 'package:bladderly/presentation/generated/assets/assets.gen.dart';

enum SymptomSurveyResultModel {
  noSymptom(
    text: 'No Symptom',
    description:
        'Your score currently indicates no symptoms. Continue to take IPSS questionnaire monthly to monitor any changes.',
    min: 0,
    max: 0,
  ),
  mild(
    text: 'Mild',
    description:
        'Your score indicates moderate prostate symptoms that do not significantly impact your quality of life. If discomfort occurs, medication or procedures may be required.',
    min: 1,
    max: 7,
  ),
  moderate(
    text: 'Moderate',
    description:
        'Your score indicates moderate prostate symptoms with noticeable discomfort. It is recommended to seek medical assistance. Medication or procedures may be necessary.',
    min: 8,
    max: 19,
  ),
  severe(
    text: 'Severe',
    description:
        'Your score indicates severe prostate symptoms with noticeable discomfort. It is recommended to seek medical assistance. Medication or procedures may be necessary.',
    min: 20,
    max: 35,
  ),
  ;

  const SymptomSurveyResultModel({
    required this.text,
    required this.description,
    required this.min,
    required this.max,
  });

  factory SymptomSurveyResultModel.fromTotalScore(int totalScore) {
    if (totalScore <= noSymptom.max) {
      return noSymptom;
    } else if (totalScore <= mild.max) {
      return mild;
    } else if (totalScore <= moderate.max) {
      return moderate;
    } else {
      return severe;
    }
  }

  final String text;
  final String description;
  final int min;
  final int max;

  AssetGenImage get icon {
    return switch (this) {
      noSymptom => Assets.img.imgSymptomFace1,
      mild => Assets.img.imgSymptomFace2,
      moderate => Assets.img.imgSymptomFace3,
      severe => Assets.img.imgSymptomFace4,
    };
  }

  Color get color {
    return switch (this) {
      noSymptom => const Color(0xFF94A22F),
      mild => const Color(0xFF94A22F),
      moderate => const Color(0xFFFF8D38),
      severe => const Color(0xFFFF6442),
    };
  }
}
