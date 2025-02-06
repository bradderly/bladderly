import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/extension/string_extension.dart';
import 'package:bradderly/presentation/feature/menu/symptom/data/symptom_dataset.dart';
import 'package:bradderly/presentation/feature/menu/symptom/symptom_survey_modal.dart';
import 'package:bradderly/presentation/feature/menu/widget/modal_title_back.dart';
import 'package:flutter/material.dart';

class SymptomIntroduceModal extends StatelessWidget {
  SymptomIntroduceModal({required this.symptom_type});

  final String symptom_type;

  @override
  Widget build(BuildContext context) {
    print('symptom_type: $symptom_type'); 
    Map<String, dynamic> symptom_data = {};
    if (symptom_type == "IPSS") {
      symptom_data = Symptom_information[0];
    } else if (symptom_type == "OABSS") {
      symptom_data = Symptom_information[1];
    }
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ModalTitleBack(context, symptom_type.tr(context)),
                    const SizedBox(height: 39.5),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        symptom_type.tr(context),
                        style: context.textStyleTheme.b28Bold.copyWith(
                            color: context.colorTheme.neutral.shade10),
                      ),
                    ),
                    Container(
                      width: 225,
                      margin: const EdgeInsets.only(left: 16),
                      child: Text(
                       symptom_data['descript'].toString().tr(context),
                        style: context.textStyleTheme.b14Medium.copyWith(
                            color: context.colorTheme.neutral.shade7,),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 16, top: 16),
                      child: Row(children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                           decoration: BoxDecoration(
                            color: context.colorTheme.vermilion.primary.shade40,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            symptom_data['time'].toString().tr(context),
                            style: context.textStyleTheme.b14SemiBold.copyWith(
                                color: context.colorTheme.neutral.shade0),
                          ),
                        ),
                        SizedBox(width: 8,),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                           decoration: BoxDecoration(
                            color: context.colorTheme.vermilion.primary.shade40,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            symptom_data['qustion_count'].toString().tr(context),
                            style: context.textStyleTheme.b14SemiBold.copyWith(
                                color: context.colorTheme.neutral.shade0),
                          ),
                        ),
                      ],),
                    ),

                    SizedBox(height: 40,),
                      Container(
                        margin: const EdgeInsets.only(left: 16, right :16),
                          padding: EdgeInsets.all(24),
                           decoration: BoxDecoration(
                            color: context.colorTheme.neutral.shade2,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            symptom_data['content'].toString().tr(context),
                            style: context.textStyleTheme.b16SemiBold.copyWith(
                                color: context.colorTheme.neutral.shade9),
                          ),
                        ),
                  ],)
              ),
              GestureDetector(
                onTap:(){
                  
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      return SymptomSurveyModal(symptom_type:symptom_type);
                    },
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 109, vertical: 12),
                  decoration: BoxDecoration(
                    color: context.colorTheme.vermilion.primary.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text('Start'.tr(context),
                      style: context.textStyleTheme.b16SemiBold.copyWith(
                        color: context.colorTheme.neutral.shade0,
                      )),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
