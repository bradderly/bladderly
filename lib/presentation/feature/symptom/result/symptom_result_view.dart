// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:bladderly/domain/model/score.dart';
import 'package:bladderly/domain/model/score_type.dart';
// Project imports:
import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/datetime_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/widget/modal_app_bar.dart';
import 'package:bladderly/presentation/feature/symptom/model/symptom_survey_result_model.dart';
import 'package:bladderly/presentation/feature/symptom/scores/cubit/symptom_scores_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SymptomResultView extends StatelessWidget {
  const SymptomResultView({
    super.key,
    required this.score,
  });

  final Score score;

  SymptomSurveyResultModel get result => SymptomSurveyResultModel.fromTotalScore(
        totalScore: score.totalScore,
        surveyType: score.type,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ModalAppBar(title: score.type.name.tr(context)),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                controller: ModalScrollController.of(context),
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildDate(context),
                      const Gap(40),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(top: 24, bottom: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: context.shadowTheme.shadow1,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: GaugeWidget(score: score),
                      ),
                      const Gap(32),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(7, (index) {
                              if (index.isEven) {
                                return VerticalDivider(
                                  color: context.colorTheme.neutral.shade4,
                                  width: 1,
                                  thickness: 1,
                                );
                              }

                              final result = SymptomSurveyResultModel.values.sublist(1)[index ~/ 2];

                              return Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      result.text.tr(context),
                                      style: context.textStyleTheme.b14SemiBold.copyWith(
                                        color: context.colorTheme.neutral.shade7,
                                      ),
                                    ),
                                    Text(
                                      switch (score.type) {
                                        ScoreType.IPSS => '${result.ipssMin}-${result.ipssMax}',
                                        ScoreType.OABSS => '${result.oabssMin}-${result.oabssMax}',
                                      },
                                      style: context.textStyleTheme.b14SemiBold.copyWith(
                                        color: context.colorTheme.neutral.shade7,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                      const Gap(32),
                      if (score.type == ScoreType.IPSS) ...[
                        Text(
                          result
                              .getDescription(scoreType: score.type, qolScore: score.qolAnswer)
                              .tr(context)
                              .applyWordBreak(),
                          style: context.textStyleTheme.b16Medium.copyWith(
                            color: context.colorTheme.neutral.shade10,
                          ),
                        ),
                        const Gap(20),
                      ],
                      Text(
                        'This is not a diagnosis. Consult with your doctor or medical professional if you have concerns about your condition.'
                            .tr(context),
                        style: context.textStyleTheme.b14Medium.copyWith(
                          color: context.colorTheme.neutral.shade6,
                        ),
                      ),
                    ],
                  ),
                  const Gap(24),
                ],
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => switch (score.type) {
                ScoreType.IPSS => context
                  ..read<SymptomScoresCubit>().expandIpss()
                  ..pop(),
                ScoreType.OABSS => context
                  ..read<SymptomScoresCubit>().expandOabss()
                  ..pop(),
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 109, vertical: 12),
                decoration: BoxDecoration(
                  color: context.colorTheme.vermilion.primary.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Confirm'.tr(context),
                  style: context.textStyleTheme.b16SemiBold.copyWith(
                    color: context.colorTheme.neutral.shade0,
                  ),
                ),
              ),
            ),
            const Gap(28),
          ],
        ),
      ),
    );
  }

  Widget _buildDate(BuildContext context) {
    return Column(
      children: [
        Text(
          score.date.getDayMonthDateTr(context),
          style: context.textStyleTheme.b16SemiBold.copyWith(
            color: context.colorTheme.neutral.shade10,
          ),
          textAlign: TextAlign.center,
        ),
        const Gap(4),
        Text(
          score.date.formatHourMinute(context),
          style: context.textStyleTheme.b14SemiBold.copyWith(
            color: context.colorTheme.neutral.shade6,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class GaugeWidget extends StatelessWidget {
  const GaugeWidget({super.key, required this.score});
  final Score score;

  SymptomSurveyResultModel get result => SymptomSurveyResultModel.fromTotalScore(
        surveyType: score.type,
        totalScore: score.totalScore,
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            CustomPaint(
              size: const Size(220, 110),
              painter: GaugePainter(score.totalScore / score.type.maxTotalScore),
            ),
            Positioned(
              bottom: 16,
              left: (220 - 50) / 2,
              child: result.icon.svg(
                width: 50,
                height: 50,
              ),
            ),
          ],
        ),
        Text(
          result.text.tr(context),
          style: context.textStyleTheme.b20Bold.copyWith(color: result.color),
        ),
        const Gap(4),
        Text(
          '${'Score:'.tr(context)} ${score.totalScore}',
          style: context.textStyleTheme.b14Medium.copyWith(
            color: context.colorTheme.neutral.shade7,
          ),
        ),
      ],
    );
  }
}

class GaugePainter extends CustomPainter {
  GaugePainter(this.percentage);
  final double percentage;

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          const Color(0xFF94A22F).withValues(alpha: 0.3),
          const Color(0xFFD97A3B).withValues(alpha: 0.3),
          const Color(0xFFFF6442).withValues(alpha: 0.3),
        ],
        stops: const [0.0, 0.2, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..strokeWidth = 22
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color(0xFF94A22F),
          Color(0xFFD97A3B),
          Color(0xFFFF6442),
        ],
        stops: [0.0, 0.2, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..strokeWidth = 22
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2;
    const startAngle = pi;
    final sweepAngle = pi * percentage;

    canvas
      ..drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, pi, false, backgroundPaint)
      ..drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, sweepAngle, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
