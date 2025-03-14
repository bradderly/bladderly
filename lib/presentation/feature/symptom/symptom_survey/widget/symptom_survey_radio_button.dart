import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/feature/symptom/model/symptom_survery_answer_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SymptomSurveyAnswerWidget extends StatelessWidget {
  const SymptomSurveyAnswerWidget({
    super.key,
    required this.isSelected,
    required this.answer,
  });

  final bool isSelected;
  final SymptomSurveryAnswerModel answer;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(2),
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected ? context.colorTheme.vermilion.primary.shade50 : context.colorTheme.neutral.shade5,
              width: 2,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? context.colorTheme.vermilion.primary.shade50 : Colors.transparent,
            ),
          ),
        ),
        const Gap(24),
        Text(
          answer.text.tr(context),
          style: context.textStyleTheme.b16Medium.copyWith(
            color: isSelected ? context.colorTheme.neutral.shade10 : context.colorTheme.neutral.shade6,
          ),
        ),
      ],
    );
  }
}
