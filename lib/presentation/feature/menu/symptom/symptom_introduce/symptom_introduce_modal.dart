// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/feature/menu/symptom/data/symptom_dataset.dart';
import 'package:bladderly/presentation/feature/menu/symptom/symptom_survey/symptom_survey_modal.dart';
import 'package:bladderly/presentation/feature/menu/widget/modal_title_back.dart';

class SymptomIntroduceModal extends StatelessWidget {
  // ignore: non_constant_identifier_names
  const SymptomIntroduceModal({super.key, required this.symptom_type});

  // ignore: non_constant_identifier_names
  final String symptom_type;

  @override
  Widget build(BuildContext context) {
    var symptomData = <String, dynamic>{};

    if (symptom_type == 'IPSS') {
      symptomData = Symptom_information[0];
    } else if (symptom_type == 'OABSS') {
      symptomData = Symptom_information[1];
    }
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
              ModalTitleBack(context, symptom_type.tr(context)),
              const SizedBox(height: 39.5),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          symptom_type.tr(context),
                          style: context.textStyleTheme.b28Bold.copyWith(
                            color: context.colorTheme.neutral.shade10,
                          ),
                        ),
                      ),
                      Container(
                        width: 225,
                        margin: const EdgeInsets.only(left: 16),
                        child: Text(
                          symptomData['descript'].toString().tr(context),
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
                                symptomData['time'].toString().tr(context),
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
                                symptomData['qustion_count'].toString().tr(context),
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
                          symptomData['content'].toString().tr(context),
                          style: context.textStyleTheme.b16SemiBold.copyWith(color: context.colorTheme.neutral.shade9),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // ignore: inference_failure_on_function_invocation
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      return SymptomSurveyModal(symptom_type: symptom_type);
                    },
                  );
                },
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
