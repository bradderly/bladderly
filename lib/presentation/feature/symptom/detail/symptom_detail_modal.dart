// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars, avoid_dynamic_calls

import 'package:bladderly/domain/model/score.dart';
// Project imports:
import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/widget/modal_app_bar.dart';
import 'package:bladderly/presentation/feature/symptom/model/symptom_survey_model.dart';
import 'package:bladderly/presentation/feature/symptom/model/symptom_survey_question_model.dart';
import 'package:bladderly/presentation/feature/symptom/model/symptom_survey_result_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SymptomDetailView extends StatelessWidget {
  const SymptomDetailView({super.key, required this.score});

  final Score score;

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('EEEE, MMM d').format(score.date); // "Tuesday, Mar 9"
    final formattedTime = DateFormat('h:mm a').format(score.date); // "7:35 PM"
    return Scaffold(
      appBar: ModalAppBar.withTitleWidget(
        backButton: true,
        title: Column(
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
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          controller: ModalScrollController.of(context),
          physics: const ClampingScrollPhysics(),
          children: [
            Row(
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
                      const Gap(8),
                      Text(
                        SymptomSurveyResultModel.fromTotalScore(
                          surveyType: score.type,
                          totalScore: score.totalScore,
                        ).text.tr(context),
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
            const Gap(42),
            ...List.generate(score.answers.length * 2 - 1, (index) {
              if (index.isOdd) return const Gap(24);

              return _buildAnswer(
                context,
                question: SymptomSurveyModel.getByScoreType(score.type).questions[index ~/ 2],
                answer: score.answers[index ~/ 2],
                score: score.getScoreByAnswerIndex(index ~/ 2),
              );
            }),
            const Gap(55),
          ],
        ),
      ),
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
