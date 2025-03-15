// Flutter imports:
// Project imports:
import 'dart:math';

import 'package:bladderly/presentation/common/bloc/user_bloc.dart';
import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/util/text_size_util.dart';
import 'package:bladderly/presentation/common/widget/progress_indicator_modal.dart';
import 'package:bladderly/presentation/feature/menu/widget/modal_title.dart';
import 'package:bladderly/presentation/feature/symptom/model/symptom_survey_model.dart';
import 'package:bladderly/presentation/feature/symptom/symptom_survey/bloc/symptom_survey_bloc.dart';
import 'package:bladderly/presentation/feature/symptom/symptom_survey/cubit/symptom_survey_form_cubit.dart';
import 'package:bladderly/presentation/feature/symptom/symptom_survey/widget/symptom_survey_radio_button.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';
import 'package:bladderly/presentation/router/route/symtom_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SymptomSurveyView extends StatefulWidget {
  const SymptomSurveyView({super.key, required this.symptomSurveyModel});

  final SymptomSurveyModel symptomSurveyModel;

  @override
  State<SymptomSurveyView> createState() => _SymptomSurveyViewState();
}

class _SymptomSurveyViewState extends State<SymptomSurveyView> {
  void onPreviousQuestion() {
    if (context.read<SymptomSurveyFormCubit>().state.index < 1) {
      return context.pop();
    }

    context.read<SymptomSurveyFormCubit>().previousQuestion();
  }

  void onNextQuestion() {
    if (context.read<SymptomSurveyFormCubit>().state.isLastQuestion) {
      final event = SymptomSurveySubmit(
        userId: context.read<UserBloc>().state.userModelOrThrowException.id,
        answers: context.read<SymptomSurveyFormCubit>().state.answers.map((answer) => answer!.sequence).toList(),
        scoreType: widget.symptomSurveyModel.scoreType,
      );

      context.read<SymptomSurveyBloc>().add(event);
      return;
    }

    context.read<SymptomSurveyFormCubit>().nextQuestion();
  }

  Future<void> onSubmitSuccess(BuildContext context, SymptomSurveySubmitSuccess state) async {
    const SymptomScoresRoute().go(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SymptomSurveyBloc, SymptomSurveyState>(
      listener: (context, state) => switch (state) {
        SymptomSurveySubmitInProgress() =>
          ProgressIndicatorModal.show(SymptomShellRoute.$navigatorKey.currentContext!, useRootNavigator: false),
        SymptomSurveySubmitSuccess() => onSubmitSuccess(context, state),
        SymptomSurveySubmitFailure() => context.pop(),
        _ => null,
      },
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          onPreviousQuestion();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 41),
          color: Colors.white,
          child: Column(
            children: [
              ModalTitle(title: widget.symptomSurveyModel.scoreType.name.tr(context)),
              const SizedBox(height: 39.5),
              Expanded(
                child: BlocBuilder<SymptomSurveyFormCubit, SymptomSurveyFormState>(
                  builder: (context, state) {
                    final question = widget.symptomSurveyModel.questions[state.index];

                    return ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        _buildProgressBar(
                          context,
                          current: state.index + 1,
                          max: widget.symptomSurveyModel.questionCount,
                        ),
                        const Gap(40),
                        _buildQuestionTitle(question.title),
                        const Gap(24),
                        _buildQuestionDescription(question.content),
                        const Gap(40),
                        ...List.generate(
                          question.answers.length * 2 - 1,
                          (index) {
                            if (index.isOdd) return const Gap(24);

                            final answer = question.answers[index ~/ 2];
                            final isSelected = state.answers.contains(answer);

                            return GestureDetector(
                              onTap: () => context.read<SymptomSurveyFormCubit>().setAnswer(answer),
                              behavior: HitTestBehavior.translucent,
                              child: SymptomSurveyAnswerWidget(
                                isSelected: isSelected,
                                answer: answer,
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: onPreviousQuestion,
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: context.colorTheme.neutral.shade6,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '<- ${'Previous'.tr(context)}',
                            style: context.textStyleTheme.b16SemiBold.copyWith(
                              color: context.colorTheme.neutral.shade0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Gap(16),
                    BlocSelector<SymptomSurveyFormCubit, SymptomSurveyFormState, bool>(
                      selector: (state) => state.hasAnswer,
                      builder: (context, hasAnswer) => Expanded(
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: hasAnswer ? onNextQuestion : null,
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: hasAnswer
                                  ? context.colorTheme.vermilion.primary.shade50
                                  : context.colorTheme.neutral.shade6,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '${'Next'.tr(context)} ->',
                              style: context.textStyleTheme.b16SemiBold.copyWith(
                                color: context.colorTheme.neutral.shade0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionTitle(String title) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final textStyle = context.textStyleTheme.b20Bold.copyWith(color: context.colorTheme.neutral.shade10);

        final texts =
            widget.symptomSurveyModel.questions.titles.map((title) => title.tr(context).applyWordBreak()).toList();

        final textHeights = texts
            .map(
              (title) => TextSizeUtil.getSize(
                text: title,
                textStyle: textStyle,
                maxWidth: constraints.maxWidth,
              ).height,
            )
            .toList();

        final height = textHeights.reduce(max);

        return SizedBox(
          height: height,
          child: Text(
            title.tr(context),
            style: textStyle,
          ),
        );
      },
    );
  }

  Widget _buildQuestionDescription(String content) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final textStyle = context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade10);
        final texts =
            widget.symptomSurveyModel.questions.contents.map((text) => text.tr(context).applyWordBreak()).toList();

        final textHeights = texts
            .map(
              (title) => TextSizeUtil.getSize(
                text: title,
                textStyle: textStyle,
                maxWidth: constraints.maxWidth,
              ).height,
            )
            .toList();

        final height = textHeights.reduce(max);

        return SizedBox(
          height: height,
          child: Text(
            content.tr(context),
            style: textStyle,
          ),
        );
      },
    );
  }

  Widget _buildProgressBar(
    BuildContext context, {
    required int current,
    required int max,
  }) {
    return Container(
      height: 8,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: context.colorTheme.neutral.shade3,
        borderRadius: BorderRadius.circular(8),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) => Container(
          width: constraints.maxWidth / max * current,
          decoration: BoxDecoration(
            color: context.colorTheme.vermilion.primary.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
