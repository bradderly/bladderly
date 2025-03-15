// Flutter imports:
import 'package:bladderly/domain/model/score.dart';
import 'package:bladderly/domain/model/score_type.dart';
import 'package:bladderly/domain/model/scores.dart';
// Project imports:
import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/locale/app_locale.dart';
import 'package:bladderly/presentation/common/widget/modal_app_bar.dart';
import 'package:bladderly/presentation/feature/symptom/model/symptom_survey_model.dart';
import 'package:bladderly/presentation/feature/symptom/model/symptom_survey_result_model.dart';
import 'package:bladderly/presentation/feature/symptom/scores/cubit/symptom_scores_form_cubit.dart';
import 'package:bladderly/presentation/feature/symptom/sypmtom_detail/symptom_detail_modal.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';
import 'package:bladderly/presentation/router/route/symptom_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SymptomScoresView extends StatefulWidget {
  const SymptomScoresView({
    super.key,
  });

  @override
  State<SymptomScoresView> createState() => _SymptomScoresViewState();
}

class _SymptomScoresViewState extends State<SymptomScoresView> {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<SymptomScoresFormCubit, SymptomScoresFormState, Scores>(
      selector: (state) => state.scores,
      builder: (context, scores) => Scaffold(
        appBar: ModalAppBar(title: 'Symptom Scores'.tr(context)),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: ModalScrollController.of(context),
                  physics: const ClampingScrollPhysics(),
                  itemCount: ScoreType.values.length,
                  itemBuilder: (context, index) => SurveyItem(
                    symptomSurvey: SymptomSurveyModel.getByScoreType(ScoreType.values[index]),
                    scores: scores.whereByScoreType(ScoreType.values[index]),
                  ),
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => const SymptomReferenceRoute().go(context),
                child: Text(
                  'References'.tr(context),
                  style: context.textStyleTheme.b16SemiBold.copyWith(
                    color: context.colorTheme.vermilion.primary.shade50,
                    decoration: TextDecoration.underline,
                    decorationColor: context.colorTheme.vermilion.primary.shade50,
                  ),
                ),
              ),
              const Gap(28),
            ],
          ),
        ),
      ),
    );
  }
}

class SurveyItem extends StatefulWidget {
  const SurveyItem({
    super.key,
    required this.symptomSurvey,
    required this.scores,
  });

  final SymptomSurveyModel symptomSurvey;
  final Scores scores;

  @override
  State<SurveyItem> createState() => _SurveyItemState();
}

class _SurveyItemState extends State<SurveyItem> {
  bool isExpanded = false;

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
                widget.symptomSurvey.title.tr(context),
                style: context.textStyleTheme.b16SemiBold.copyWith(color: context.colorTheme.neutral.shade10),
              ),
              subtitle: Text(
                widget.symptomSurvey.description.tr(context),
                style: context.textStyleTheme.b12Medium.copyWith(color: context.colorTheme.neutral.shade7),
              ),
              trailing: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () =>
                    SymptomSurveyRoute($extra: SymptomSurveyRouteExtra(symptomSurveyModel: widget.symptomSurvey))
                        .go(context),
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
            if (isExpanded)
              (widget.scores.isNotEmpty)
                  ? Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.scores.length,
                          itemBuilder: (context, index) {
                            final score = widget.scores[index];
                            return GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () => showModalBottomSheet<void>(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) => SymptomDetailModal(
                                  score: score,
                                ),
                              ),
                              child: _buildScoreRow(score: score),
                            );
                          },
                        ),
                      ],
                    )
                  : Container(
                      height: 76,
                      alignment: Alignment.center,
                      child: Text(
                        'List Na Message'.tr(context),
                        style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade6),
                        textAlign: TextAlign.center,
                      ),
                    )
            else
              Container(
                margin: const EdgeInsets.only(left: 16, right: 24),
                child: const Divider(),
              ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
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
                    const SizedBox(width: 1),
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

  Widget _buildScoreRow({
    required Score score,
  }) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 16, right: 24),
          child: const Divider(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  switch (context.locale) {
                    AppLocale.en => DateFormat('MMMM dd, yyyy').format(score.date),
                    AppLocale.ko => DateFormat('yyyy년 MM월 dd일').format(score.date),
                  },
                  style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade8),
                ),
              ),
              const Gap(20),
              Row(
                children: [
                  Text(
                    '${score.totalScore}',
                    style: context.textStyleTheme.b14Medium.copyWith(
                      color: context.colorTheme.vermilion.primary.shade50,
                    ),
                  ),
                  Container(
                    width: 100,
                    margin: const EdgeInsets.only(left: 11, right: 11),
                    alignment: Alignment.centerRight,
                    child: Text(
                      SymptomSurveyResultModel.fromTotalScore(score.totalScore, score.type).name.tr(context),
                      style: context.textStyleTheme.b14Medium.copyWith(
                        color: context.colorTheme.vermilion.primary.shade50,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
