import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/extension/string_extension.dart';
import 'package:bradderly/presentation/feature/menu/symptom/symptom_descript_modal.dart';
import 'package:bradderly/presentation/feature/menu/symptom/symptom_introduce_modal.dart';
import 'package:bradderly/presentation/feature/menu/symptom/symptom_moderate_modal.dart';
import 'package:bradderly/presentation/feature/menu/widget/modal_title.dart';
import 'package:flutter/material.dart';

class SymptomModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      maxChildSize: 0.95,
      minChildSize: 0.95,
      builder: (_, controller) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 41),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  controller: controller,
                  children: [
                    ModalTitle(context, 'Symptom Scores'.tr(context)),
                    const SizedBox(height: 40),
                    SurveyItem(
                        title: 'I-PSS',
                        subtitle:
                            'International Prostate Symptom Score'.tr(context),
                            score: 2),
                    SurveyItem(
                        title: 'OABSS',
                        subtitle:
                            'Overactive Bladder Symptom Score'.tr(context),
                            score: 0),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      return SymptomDescriptModal();
                    },
                  );
                },
                child: Text('Learn about the tests'.tr(context),
                    style: context.textStyleTheme.b16SemiBold.copyWith(
                      color: context.colorTheme.vermilion.primary.shade50,
                      decoration: TextDecoration.underline,
                      decorationColor:
                          context.colorTheme.vermilion.primary.shade50,
                    )),
              )
            ],
          ),
        );
      },
    );
  }
}

class SurveyItem extends StatefulWidget {
  final String title;
  final String subtitle;
  final int score;

  SurveyItem({required this.title, required this.subtitle, this.score = 0});

  @override
  _SurveyItemState createState() => _SurveyItemState();
}

class _SurveyItemState extends State<SurveyItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: context.colorTheme.neutral.shade2,
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.only(left: 16, top: 24, right: 16),
              title: Text(widget.title,
                  style: context.textStyleTheme.b16SemiBold
                      .copyWith(color: context.colorTheme.neutral.shade10)),
              subtitle: Text(widget.subtitle.tr(context),
                  style: context.textStyleTheme.b12Medium
                      .copyWith(color: context.colorTheme.neutral.shade7)),
              trailing: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      print(widget.title.replaceAll("-", ""));
                      return SymptomIntroduceModal(symptom_type: widget.title.replaceAll("-", ""));
                    },
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: context.colorTheme.vermilion.primary.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
            (isExpanded)
                ? (widget.score != 0)
                    ? Column(
                        children: [
                          _buildScoreRow('Nov 12, 2024', 18, 'IPSS'),
                          _buildScoreRow('Nov 10, 2024', 24, 'OABSS'),
                        ],
                      )
                    : Container(
                      height: 76,
                        alignment: Alignment.center,
                        child: Text(
                          'Looks like there’s nothing here yet.\nLet’s get started!'.tr(context),
                          style: context.textStyleTheme.b14Medium.copyWith(
                              color: context.colorTheme.neutral.shade6),
                          textAlign: TextAlign.center,
                        ))
                : Container(
                    margin: EdgeInsets.only(left: 16, right: 24),
                    child: Divider()),
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Container(
                padding: EdgeInsets.only(top: 18, bottom: 24),
                decoration: BoxDecoration(
                  color: Colors.transparent, // 필요하면 배경색 추가 가능
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: context.colorTheme.neutral.shade7,
                      size: 16,
                    ),
                    SizedBox(width: 1),
                    Text(
                      isExpanded
                          ? 'See less'.tr(context)
                          : 'See more'.tr(context),
                      style: context.textStyleTheme.b14Medium.copyWith(
                        color: context.colorTheme.neutral.shade7,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildScoreRow(String date, int score, String symptom_type) {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.only(left: 16, right: 24), child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(date,
                  style: context.textStyleTheme.b14Medium
                      .copyWith(color: context.colorTheme.neutral.shade8)),
              Row(
                children: [
                  Text(score.toString(),
                      style: context.textStyleTheme.b14Medium.copyWith(
                          color: context.colorTheme.vermilion.primary.shade50)),
                  SizedBox(width: 19),
                  GestureDetector(
                    onTap:(){
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) {
                          return SymptomModerateModal(symptom_type:symptom_type );
                        },
                      );
                    },
                    child: Text('Moderate'.tr(context),
                        style: context.textStyleTheme.b14Medium.copyWith(
                            color: context.colorTheme.vermilion.primary.shade50)),
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
