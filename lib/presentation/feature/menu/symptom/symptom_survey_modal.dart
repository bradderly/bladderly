import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/extension/string_extension.dart';
import 'package:bradderly/presentation/feature/menu/symptom/data/symptom_dataset.dart';
import 'package:bradderly/presentation/feature/menu/symptom/symptom_result_modal.dart';
import 'package:bradderly/presentation/feature/menu/widget/modal_title.dart';
import 'package:flutter/material.dart';

class SymptomSurveyModal extends StatefulWidget {
  // ignore: non_constant_identifier_names
  const SymptomSurveyModal({super.key, required this.symptom_type});
  // ignore: non_constant_identifier_names
  final String symptom_type;

  @override
  State<SymptomSurveyModal> createState() => _SymptomSurveyModalState();
}

class _SymptomSurveyModalState extends State<SymptomSurveyModal> {
  int currentIndex = 0;
  int? selectedOption;

  late List<Map<String, dynamic>> questions;

  late List<int> asnwers = [];
  @override
  void initState() {
    super.initState();
    if (widget.symptom_type == 'IPSS') {
      questions = IPSS_Q;
    } else if (widget.symptom_type == 'OABSS') {
      questions = OABSS_Q;
    }
  }

  void onNext() {
    if (currentIndex < questions.length - 1) {
      setState(() {
        asnwers.add(selectedOption!);
        currentIndex++;
        selectedOption = null;
      });
    } else if (currentIndex == questions.length - 1) {
      asnwers.add(selectedOption!);

      // ignore: inference_failure_on_function_invocation
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return SymptomResultModal(
            symptom_type: widget.symptom_type,
            score: 13,
            status: 'Moderate',
            description:
                '"Your score indicates moderate prostate symptoms that do not significantly impact your quality of life. If discomfort occurs, medication or procedures may be required."',
            dateTime: 'Tuesday, Nov 15\n9:00 AM',
          );
        },
      );
    }
  }

  void onPrevious() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;

        selectedOption = asnwers.last;
        asnwers.removeLast();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentIndex];

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
              Expanded(
                child: ListView(
                  controller: controller,
                  children: [
                    ModalTitle(context, widget.symptom_type.tr(context)),
                    const SizedBox(height: 39.5),
                    // Progress Bar
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: (currentIndex + 1) / questions.length,
                          backgroundColor: context.colorTheme.neutral.shade3,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            context.colorTheme.vermilion.primary.shade50,
                          ),
                          minHeight: 8,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        currentQuestion['title'].toString().tr(context),
                        style: context.textStyleTheme.b20Bold.copyWith(
                          color: context.colorTheme.neutral.shade10,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        currentQuestion['content'].toString().tr(context),
                        style: context.textStyleTheme.b16Medium.copyWith(
                          color: context.colorTheme.neutral.shade10,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Options

                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true, // 크기를 제한
                        itemCount: (currentQuestion['answer'] as List)
                            .length, // 명시적 타입 캐스팅
                        itemBuilder: (context, index) {
                          final answers = currentQuestion['answer']
                              as List<Map<String, dynamic>>; // 타입 지정
                          final option = answers[index]['content']
                              as String; // 'content' 접근
                          return ListTile(
                            title: Text(
                              option.tr(context),
                              style: context.textStyleTheme.b16Medium.copyWith(
                                color: context.colorTheme.neutral.shade6,
                              ),
                            ),
                            leading: Radio<int>(
                              value: index,
                              groupValue: selectedOption,
                              fillColor: WidgetStateProperty.resolveWith<Color>(
                                  (states) {
                                if (states.contains(WidgetState.selected)) {
                                  return context.colorTheme.vermilion.primary
                                      .shade50; // 선택된 상태일 때 색상
                                }
                                return context
                                    .colorTheme.neutral.shade6; // 기본 색상
                              }),
                              onChanged: (value) {
                                setState(() {
                                  selectedOption = value;
                                });
                              },
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 2,
                            ), // 기본 패딩 줄이기
                            dense: true, // ListTile의 높이를 더 줄이기
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // Navigation Buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: currentIndex == 0 ? null : onPrevious,
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: context.colorTheme.neutral.shade6,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '<- ${'Previous'.tr(context)}',
                                style:
                                    context.textStyleTheme.b16SemiBold.copyWith(
                                  color: context.colorTheme.neutral.shade0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: GestureDetector(
                        onTap: selectedOption == null ? null : onNext,
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: context.colorTheme.vermilion.primary.shade50,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${'Next'.tr(context)} ->',
                                style:
                                    context.textStyleTheme.b16SemiBold.copyWith(
                                  color: context.colorTheme.neutral.shade0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
