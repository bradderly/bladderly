// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars, avoid_dynamic_calls

import 'package:bladderly/domain/model/score.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/feature/menu/symptom/data/symptom_dataset.dart';
import 'package:bladderly/presentation/feature/menu/widget/modal_title_date_back.dart';
import 'package:intl/intl.dart';

class SymptomResultDetailModal extends StatelessWidget {
  const SymptomResultDetailModal({super.key, required this.score});

  final Score score;
  @override
  Widget build(BuildContext context) {
    String severityText;
    if (score.totalScore == 0) {
      severityText = 'No Symptom';
    } else if (score.totalScore >= 1 && score.totalScore <= 7) {
      severityText = 'Mild';
    } else if (score.totalScore >= 8 && score.totalScore <= 19) {
      severityText = 'Moderate';
    } else if (score.totalScore >= 20 && score.totalScore <= 35) {
      severityText = 'Severe';
    } else {
      severityText = 'Unknown';
    }
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
              ModalTitleDateBack(
                context,
                formattedDate.tr(context),
                formattedTime.tr(context),
              ),
              const SizedBox(height: 24),
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
                                const SizedBox(height: 4),
                                Text(
                                  severityText.tr(context),
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
                              score.totalScore.toString(),
                              style: context.textStyleTheme.b28Bold.copyWith(
                                color: context.colorTheme.neutral.shade0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    for (var i = 0; i < score.values.length; i++)
                      if (score.type.name == 'IPSS')
                        _buildScoreRow(
                          context,
                          IPSS_Q[i],
                          score.values[i],
                        )
                      else if (score.type.name == 'OABSS')
                        _buildScoreRow(
                          context,
                          OABSS_Q[i],
                          score.values[i],
                        ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildScoreRow(
    BuildContext context,
    Map<String, dynamic> symptomData,
    int result,
  ) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 28, bottom: 20),
      padding: const EdgeInsets.only(left: 16, top: 24, right: 16, bottom: 15),
      decoration: BoxDecoration(
        color: context.colorTheme.neutral.shade2,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Q${symptomData['num']}',
            style: context.textStyleTheme.b16SemiBold.copyWith(
              color: context.colorTheme.neutral.shade10,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              children: [
                Text(
                  symptomData['content'].toString().tr(context),
                  style: context.textStyleTheme.b14Medium.copyWith(
                    color: context.colorTheme.neutral.shade9,
                  ),
                ),
                const SizedBox(height: 24),
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
                        symptomData['answer'][result]['content'].toString().tr(context),
                        style: context.textStyleTheme.b14Medium.copyWith(
                          color: context.colorTheme.neutral.shade7,
                        ),
                      ),
                      Text(
                        result.toString(),
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
