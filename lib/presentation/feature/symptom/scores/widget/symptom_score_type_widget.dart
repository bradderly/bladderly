import 'package:bladderly/domain/model/score.dart';
import 'package:bladderly/domain/model/scores.dart';
import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/locale/app_locale.dart';
import 'package:bladderly/presentation/feature/symptom/model/symptom_survey_model.dart';
import 'package:bladderly/presentation/feature/symptom/model/symptom_survey_result_model.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';
import 'package:bladderly/presentation/router/route/symptom_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class SymptomScoreTypeWidget extends StatelessWidget {
  const SymptomScoreTypeWidget({
    super.key,
    required this.onTap,
    required this.isExpanded,
    required this.symptomSurvey,
    required this.scores,
  });

  final VoidCallback onTap;
  final bool isExpanded;
  final SymptomSurveyModel symptomSurvey;
  final Scores scores;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: context.colorTheme.neutral.shade2,
        child: Column(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.only(left: 16, top: 24, right: 16),
              title: Text(
                symptomSurvey.title.tr(context),
                style: context.textStyleTheme.b16SemiBold.copyWith(color: context.colorTheme.neutral.shade10),
              ),
              subtitle: Text(
                symptomSurvey.subtitle.tr(context),
                style: context.textStyleTheme.b12Medium.copyWith(color: context.colorTheme.neutral.shade7),
              ),
              trailing: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => SymptomIntroduceRoute(scoreType: symptomSurvey.scoreType).go(context),
                child: Container(
                  decoration: BoxDecoration(
                    color: context.colorTheme.vermilion.primary.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Text(
                    'Take'.tr(context),
                    style: context.textStyleTheme.b12SemiBold.copyWith(
                      color: context.colorTheme.neutral.shade0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            if (isExpanded && scores.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: scores.length,
                itemBuilder: (context, index) {
                  final score = scores[index];
                  return GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () => SymptomDetailRoute($extra: SymptomDetailRouteExtra(score: score)).go(context),
                    child: _buildScoreRow(context, score: score),
                  );
                },
              )
            else if (isExpanded && scores.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 21),
                alignment: Alignment.center,
                child: Text(
                  'List Na Message'.tr(context),
                  style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade6),
                  textAlign: TextAlign.center,
                ),
              )
            else
              Container(margin: const EdgeInsets.only(left: 16, right: 24), child: const Divider()),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.only(top: 18, bottom: 24),
                decoration: BoxDecoration(
                  color: Colors.transparent, // 필요하면 배경색 추가 가능
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                      color: context.colorTheme.neutral.shade7,
                      size: 16,
                    ),
                    const Gap(1),
                    Text(
                      isExpanded ? 'See less'.tr(context) : 'See more'.tr(context),
                      style: context.textStyleTheme.b14Medium.copyWith(
                        color: context.colorTheme.neutral.shade7,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreRow(
    BuildContext context, {
    required Score score,
  }) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 16, right: 24),
          child: const Divider(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4).copyWith(left: 16, right: 24),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  switch (context.locale) {
                    AppLocale.en => DateFormat('MMM dd, yyyy').format(score.date),
                    AppLocale.ko => DateFormat('yyyy년 MM월 dd일').format(score.date),
                  },
                  style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade8),
                ),
              ),
              const Gap(34),
              Text(
                '${score.totalScore}',
                style: context.textStyleTheme.b14Medium.copyWith(
                  color: context.colorTheme.vermilion.primary.shade50,
                ),
              ),
              const Gap(34),
              Container(
                width: 87,
                alignment: Alignment.centerRight,
                child: Text(
                  SymptomSurveyResultModel.fromTotalScore(
                    surveyType: score.type,
                    totalScore: score.totalScore,
                  ).text.tr(context),
                  style: context.textStyleTheme.b14Medium.copyWith(
                    color: context.colorTheme.vermilion.primary.shade50,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
