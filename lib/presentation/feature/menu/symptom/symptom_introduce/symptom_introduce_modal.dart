// Flutter imports:
// Project imports:
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/feature/menu/symptom/model/symptom_survey_model.dart';
import 'package:bladderly/presentation/feature/menu/symptom/symptom_survey/symptom_survey_builder.dart';
import 'package:bladderly/presentation/feature/menu/utils/modal_helper.dart';
import 'package:bladderly/presentation/feature/menu/widget/modal_title_back.dart';
import 'package:flutter/material.dart';

class SymptomIntroduceModal extends StatelessWidget {
  const SymptomIntroduceModal({super.key, required this.symptomSurveyModel});

  final SymptomSurveyModel symptomSurveyModel;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      maxChildSize: 0.95,
      minChildSize: 0.95,
      builder: (_, controller) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 41),
          child: Column(
            children: [
              ModalTitleBack(context, symptomSurveyModel.scoreType.name.tr(context)),
              const SizedBox(height: 39.5),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          symptomSurveyModel.scoreType.name.tr(context),
                          style: context.textStyleTheme.b28Bold.copyWith(
                            color: context.colorTheme.neutral.shade10,
                          ),
                        ),
                      ),
                      Container(
                        width: 225,
                        margin: const EdgeInsets.only(left: 16),
                        child: Text(
                          symptomSurveyModel.subtitle.tr(context),
                          style: context.textStyleTheme.b14Medium.copyWith(
                            color: context.colorTheme.neutral.shade7,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, top: 16),
                        child: Row(
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
                            const SizedBox(
                              width: 8,
                            ),
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
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 16, right: 16),
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
              GestureDetector(
                onTap: () => ModalHelper.showModal<void>(
                  context: context,
                  modalBuilder: (_) => SymptomSurveyBuilder(symptomSurveyModel: symptomSurveyModel),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 109, vertical: 12),
                  decoration: BoxDecoration(
                    color: context.colorTheme.vermilion.primary.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Start'.tr(context),
                    style: context.textStyleTheme.b16SemiBold.copyWith(
                      color: context.colorTheme.neutral.shade0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
