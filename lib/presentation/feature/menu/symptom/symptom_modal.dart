// Flutter imports:
import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/presentation/common/bloc/user_bloc.dart';
import 'package:bladderly/presentation/common/widget/progress_indicator_modal.dart';
import 'package:bladderly/presentation/feature/menu/symptom/bloc/symptom_history_bloc.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/feature/menu/symptom/symptom_descript/symptom_descript_modal.dart';
import 'package:bladderly/presentation/feature/menu/symptom/symptom_introduce/symptom_introduce_modal.dart';
import 'package:bladderly/presentation/feature/menu/symptom/symptom_morderate/symptom_moderate_modal.dart';
import 'package:bladderly/presentation/feature/menu/widget/modal_title.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SymptomModal extends StatelessWidget {
  const SymptomModal({super.key});

  @override
  Widget build(BuildContext context) {
    final userBlocState = context.read<UserBloc>().state;
    final userId = userBlocState.userModelOrThrowException.id;
    context.read<SymptomHistoryBloc>().add(SymptomHistory(userId: userId));
    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      maxChildSize: 0.95,
      minChildSize: 0.95,
      builder: (_, controller) {
        return BlocListener<SymptomHistoryBloc, SymptomHistoryState>(listener: (context, state) {
          switch (state) {
            case SymptomHistoryProgress():
              ProgressIndicatorModal.show(context);
            case SymptomHistorySuccess():
              print('LOGTAG 4444');
            case SymptomHistoryFailure():
              print('Error loading scores: scores history : ${state.exception}');
            default:
              break;
          }
        }, child: BlocBuilder<SymptomHistoryBloc, SymptomHistoryState>(
          builder: (context, state) {
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
                  ModalTitle(context, 'Symptom Score'.tr(context)),
                  const SizedBox(height: 40),
                  Expanded(
                    child: ListView(
                      controller: controller,
                      children: [
                        SurveyItem(
                          title: 'I-PSS',
                          subtitle: 'International Prostate Symptom Score'.tr(context),
                          score: 2,
                        ),
                        SurveyItem(
                          title: 'OABSS',
                          subtitle: 'Overactive Bladder Symptom Score'.tr(context),
                          // ignore: avoid_redundant_argument_values
                          score: 0,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      // ignore: inference_failure_on_function_invocation
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) {
                          return const SymptomDescriptModal();
                        },
                      );
                    },
                    child: Text(
                      'References'.tr(context),
                      style: context.textStyleTheme.b16SemiBold.copyWith(
                        color: context.colorTheme.vermilion.primary.shade50,
                        decoration: TextDecoration.underline,
                        decorationColor: context.colorTheme.vermilion.primary.shade50,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
      },
    );
  }
}

class SurveyItem extends StatefulWidget {
  const SurveyItem({
    super.key,
    required this.title,
    required this.subtitle,
    this.score = 0,
  });
  final String title;
  final String subtitle;
  final int score;

  @override
  // ignore: library_private_types_in_public_api
  _SurveyItemState createState() => _SurveyItemState();
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
                widget.title,
                style: context.textStyleTheme.b16SemiBold.copyWith(color: context.colorTheme.neutral.shade10),
              ),
              subtitle: Text(
                widget.subtitle.tr(context),
                style: context.textStyleTheme.b12Medium.copyWith(color: context.colorTheme.neutral.shade7),
              ),
              trailing: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  // ignore: inference_failure_on_function_invocation
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      return SymptomIntroduceModal(
                        symptom_type: widget.title.replaceAll('-', ''),
                      );
                    },
                  );
                },
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
              (widget.score != 0)
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

  Widget _buildScoreRow(String date, int score, String symptomType) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 16, right: 24),
          child: const Divider(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                date,
                style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade8),
              ),
              Row(
                children: [
                  Text(
                    score.toString(),
                    style: context.textStyleTheme.b14Medium.copyWith(
                      color: context.colorTheme.vermilion.primary.shade50,
                    ),
                  ),
                  const SizedBox(width: 19),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      // ignore: inference_failure_on_function_invocation
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) {
                          return SymptomModerateModal(
                            symptom_type: symptomType,
                          );
                        },
                      );
                    },
                    child: Text(
                      'Moderate'.tr(context),
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
