
import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/extension/string_extension.dart';
import 'package:bradderly/presentation/feature/menu/symptom/data/symptom_dataset.dart';
import 'package:bradderly/presentation/feature/menu/widget/modal_title.dart';
import 'package:bradderly/presentation/feature/menu/widget/modal_title_back.dart';
import 'package:bradderly/presentation/feature/menu/widget/modal_title_date_back.dart';
import 'package:flutter/material.dart';

class SymptomModerateModal extends StatelessWidget {

  final String symptom_type;

  SymptomModerateModal({required this.symptom_type});
final List<Map<String, dynamic>> symptom_result = [
    {'num': 1, 'result': 2},
    {'num': 2,'result': 1},
    {'num': 3,  'result': 3},
    {'num': 4, 'result': 4},
    {'num': 5,'result': 3},
    {'num': 6, 'result': 2},
    {'num': 7, 'result': 1},
    {'num': 8, 'result': 2},
    ];
  @override
  Widget build(BuildContext context) {
    int qustion_count = 0;
    if(symptom_type == 'IPSS'){
       qustion_count = IPSS_Q.length;
    }else if (symptom_type == 'OABSS'){
       qustion_count = OABSS_Q.length;
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
          padding: const EdgeInsets.only(left: 8, top: 41, right: 8),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  controller: controller,
                  children: [
                    ModalTitleDateBack(context, 'Tuesday, Nov 15'.tr(context),'9:00 AM'.tr(context)),
                    const SizedBox(height: 24),
                   Padding(
                    padding: const EdgeInsets.only(left: 24, right: 25),
                     child: Row(children: [
                      Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text('Symptom Score'.tr(context),style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade7),),
                        Text('Moderate'.tr(context),style: context.textStyleTheme.b28Bold.copyWith(color: context.colorTheme.neutral.shade10),),
                      ],)),
                      Container(
                        width: 60,
                        height: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: context.colorTheme.vermilion.primary.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(qustion_count.toString(),style: context.textStyleTheme.b28Bold.copyWith(color: context.colorTheme.neutral.shade0),),)
                     ],),
                   ),
                    SizedBox(height: 30),
                    for (var i = 0; i < qustion_count; i++) 
                      if (symptom_type == 'IPSS') 
                      _buildScoreRow(context, IPSS_Q[i]['num'] as int, IPSS_Q[i]['content'] as String, IPSS_Q[i]['answer'] as List<Map<String, dynamic>>, symptom_result[i]['result'] as int)
                      else if (symptom_type == 'OABSS') 
                      _buildScoreRow(context, OABSS_Q[i]['num'] as int, OABSS_Q[i]['content'] as String, OABSS_Q[i]['answer'] as List<Map<String, dynamic>>, symptom_result[i]['result'] as int),
                  SizedBox(height: 24),
                
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget _buildScoreRow(BuildContext context,int num, String content, List<Map<String, dynamic>> answer,int result) {
  return  Container(
                      margin: EdgeInsets.only(left: 12,top: 6,right: 20,bottom: 6),
                      padding: EdgeInsets.only(left: 16, top: 24, right: 16, bottom: 32),
                      decoration: BoxDecoration(
                        color: context.colorTheme.neutral.shade2,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        crossAxisAlignment:  CrossAxisAlignment.start,
                        children: [
                        Text('Q'+num.toString(),style: context.textStyleTheme.b16SemiBold.copyWith(color: context.colorTheme.neutral.shade10),),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            children: [
                              Text('Over the past month, how often have you had the sensation of not emptying your bladder?'.tr(context),style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade9),),
                              SizedBox(height: 24),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: context.colorTheme.neutral.shade0,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                  Text(answer[result-1]['content'].toString(),style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade7),),
                                  Text(result.toString(),style: context.textStyleTheme.b16SemiBold.copyWith(color: context.colorTheme.vermilion.primary.shade50),),
                                ],),
                              )
                            ],
                          ),
                        ),
                      ],),);
}