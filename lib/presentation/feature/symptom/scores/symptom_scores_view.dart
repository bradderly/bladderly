// Flutter imports:
import 'package:bladderly/domain/model/score_type.dart';
import 'package:bladderly/domain/model/scores.dart';
// Project imports:
import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/widget/modal_app_bar.dart';
import 'package:bladderly/presentation/feature/symptom/model/symptom_survey_model.dart';
import 'package:bladderly/presentation/feature/symptom/scores/cubit/symptom_scores_cubit.dart';
import 'package:bladderly/presentation/feature/symptom/scores/widget/symptom_score_type_widget.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';
import 'package:bladderly/presentation/router/route/symptom_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
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
    return BlocSelector<SymptomScoresCubit, SymptomScoresState, Scores>(
      selector: (state) => state.scores,
      builder: (context, scores) => Scaffold(
        appBar: ModalAppBar(title: 'Symptom Scores'.tr(context)),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: ModalScrollController.of(context),
                    physics: const ClampingScrollPhysics(),
                    itemCount: ScoreType.values.length,
                    itemBuilder: (context, index) => BlocSelector<SymptomScoresCubit, SymptomScoresState, bool>(
                      selector: (state) => switch (ScoreType.values[index]) {
                        ScoreType.IPSS => state.isExpandedIpss,
                        ScoreType.OABSS => state.isExpandedOabss,
                      },
                      builder: (context, isExpanded) {
                        return SymptomScoreTypeWidget(
                          onTap: () => switch (ScoreType.values[index]) {
                            ScoreType.IPSS => context.read<SymptomScoresCubit>().toggleIpss(),
                            ScoreType.OABSS => context.read<SymptomScoresCubit>().toggleOabss(),
                          },
                          isExpanded: isExpanded,
                          symptomSurvey: SymptomSurveyModel.getByScoreType(ScoreType.values[index]),
                          scores: scores.whereByScoreType(ScoreType.values[index]),
                        );
                      },
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
      ),
    );
  }
}
