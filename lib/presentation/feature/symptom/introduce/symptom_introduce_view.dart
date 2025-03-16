// Flutter imports:
// Project imports:
import 'package:bladderly/domain/model/score_type.dart';
import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/widget/modal_app_bar.dart';
import 'package:bladderly/presentation/common/widget/primary_button.dart';
import 'package:bladderly/presentation/feature/symptom/model/symptom_survey_model.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';
import 'package:bladderly/presentation/router/route/symptom_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SymptomIntroduceView extends StatelessWidget {
  const SymptomIntroduceView({super.key, required this.scoreType});

  final ScoreType scoreType;

  SymptomSurveyModel get symptomSurveyModel => SymptomSurveyModel.getByScoreType(scoreType);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ModalAppBar(
        backButton: true,
        title: symptomSurveyModel.subtitle.tr(context),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  controller: ModalScrollController.of(context),
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        scoreType.name.tr(context),
                        style: context.textStyleTheme.b28Bold.copyWith(
                          color: context.colorTheme.neutral.shade10,
                        ),
                      ),
                      Text(
                        symptomSurveyModel.subtitle.tr(context),
                        style: context.textStyleTheme.b14Medium.copyWith(
                          color: context.colorTheme.neutral.shade7,
                        ),
                      ),
                      const Gap(16),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: context.colorTheme.vermilion.primary.shade40,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '${symptomSurveyModel.duration} min'.tr(context),
                              style: context.textStyleTheme.b14SemiBold.copyWith(
                                color: context.colorTheme.neutral.shade0,
                              ),
                            ),
                          ),
                          const Gap(8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: context.colorTheme.vermilion.primary.shade40,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '${symptomSurveyModel.questionCount} questions'.tr(context),
                              style: context.textStyleTheme.b14SemiBold.copyWith(
                                color: context.colorTheme.neutral.shade0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Gap(40),
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: context.colorTheme.neutral.shade2,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          symptomSurveyModel.description.tr(context),
                          style: context.textStyleTheme.b16SemiBold.copyWith(color: context.colorTheme.neutral.shade9),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: PrimaryButton.filled(
                  onPressed: () => SymptomSurveyRoute(scoreType: scoreType).go(context),
                  backgroundColor: context.colorTheme.vermilion.primary.shade50,
                  borderRadius: 8,
                  shape: BoxShape.rectangle,
                  text: 'Start'.tr(context),
                  textColor: context.colorTheme.neutral.shade0,
                  size: const Size(256, 43),
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
