// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars, avoid_dynamic_calls

import 'package:bladderly/domain/model/score.dart';
// Project imports:
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/feature/menu/symptom/model/symptom_survey_model.dart';
import 'package:bladderly/presentation/feature/menu/symptom/model/symptom_survey_question_model.dart';
import 'package:bladderly/presentation/feature/menu/symptom/model/symptom_survey_result_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class SymptomDetailModal extends StatelessWidget {
  const SymptomDetailModal({super.key, required this.score});

  final Score score;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      maxChildSize: 0.95,
      minChildSize: 0.95,
      builder: (_, controller) {
        final formattedDate = DateFormat('EEEE, MMM d').format(score.date); // "Tuesday, Mar 9"
        final formattedTime = DateFormat('h:mm a').format(score.date); // "7:35 PM"
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          padding: const EdgeInsets.only(left: 8, top: 41, right: 8),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          formattedDate.tr(context),
                          style: context.textStyleTheme.b16SemiBold.copyWith(
                            color: context.colorTheme.neutral.shade10,
                          ),
                        ),
                        Text(
                          formattedTime.tr(context),
                          style: context.textStyleTheme.b14SemiBold.copyWith(
                            color: context.colorTheme.neutral.shade6,
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      left: 0,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: context.colorTheme.neutral.shade10,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(24),
              Expanded(
                child: ListView(
                  controller: controller,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 24, right: 25),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  score.type.name.tr(context),
                                  style: context.textStyleTheme.b14Medium.copyWith(
                                    color: context.colorTheme.neutral.shade7,
                                  ),
                                ),
                                const Gap(4),
                                Text(
                                  SymptomSurveyResultModel.fromTotalScore(score.totalScore).name.tr(context),
                                  style: context.textStyleTheme.b28Bold.copyWith(
                                    color: context.colorTheme.neutral.shade10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 60,
                            height: 60,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: context.colorTheme.vermilion.primary.shade50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '${score.totalScore}',
                              style: context.textStyleTheme.b28Bold.copyWith(
                                color: context.colorTheme.neutral.shade0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(30),
                    ...List.generate(score.answers.length * 2 - 1, (index) {
                      if (index.isOdd) return const Gap(24);

                      return _buildAnswer(
                        context,
                        question: SymptomSurveyModel.getByScoreType(score.type).questions[index ~/ 2],
                        answer: score.answers[index ~/ 2],
                        score: score.getScoreByAnswerIndex(index ~/ 2),
                      );
                    }),
                    const Gap(24),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAnswer(
    BuildContext context, {
    required SymptomSurveyQuestionModel question,
    required int answer,
    required int score,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
        color: context.colorTheme.neutral.shade2,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Q${question.id + 1}',
            style: context.textStyleTheme.b16SemiBold.copyWith(
              color: context.colorTheme.neutral.shade10,
            ),
          ),
          const Gap(16),
          Expanded(
            child: Column(
              children: [
                Text(
                  question.content.tr(context),
                  style: context.textStyleTheme.b14Medium.copyWith(
                    color: context.colorTheme.neutral.shade9,
                  ),
                ),
                const Gap(24),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: context.colorTheme.neutral.shade0,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        question.answers[answer].text.tr(context),
                        style: context.textStyleTheme.b14Medium.copyWith(
                          color: context.colorTheme.neutral.shade7,
                        ),
                      ),
                      Text(
                        '$score',
                        style: context.textStyleTheme.b16SemiBold.copyWith(
                          color: context.colorTheme.vermilion.primary.shade50,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
