// ignore: library_prefixes

// ignore_for_file: deprecated_member_use

// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:bladderly/domain/model/score.dart';
// Project imports:
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/datetime_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/feature/menu/widget/modal_title.dart';
import 'package:bladderly/presentation/feature/symptom/model/symptom_survey_result_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SymptomResultView extends StatelessWidget {
  const SymptomResultView({
    super.key,
    required this.score,
  });

  final Score score;

  SymptomSurveyResultModel get result => SymptomSurveyResultModel.fromTotalScore(score.totalScore);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 40, bottom: 28),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                ModalTitle(title: score.type.name.tr(context)),
                const Gap(40),
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
                      child: GaugeWidget(totalScore: score.totalScore),
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
                                    '${result.min}-${result.max}',
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
                    Text(
                      result.description.applyWordBreak(),
                      style: context.textStyleTheme.b16Medium.copyWith(
                        color: context.colorTheme.neutral.shade10,
                      ),
                    ),
                    const Gap(20),
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
            onTap: context.pop,
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
          const Gap(12),
        ],
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
  const GaugeWidget({super.key, required this.totalScore});
  final int totalScore;

  SymptomSurveyResultModel get result => SymptomSurveyResultModel.fromTotalScore(totalScore);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            CustomPaint(
              size: const Size(220, 110),
              painter: GaugePainter(totalScore / 35),
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
          '${'Score:'.tr(context)} $totalScore',
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
          const Color(0xFF94A22F).withOpacity(0.3),
          const Color(0xFFD97A3B).withOpacity(0.3),
          const Color(0xFFFF6442).withOpacity(0.3),
        ],
        stops: const [0.0, 0.2, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..strokeWidth = 22
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..shader = const SweepGradient(
        colors: [Color(0xFF94A22F), Color(0xFFD97A3B), Color(0xFFFF6442)],
        stops: [0.0, 0.2, 1.0],
        startAngle: pi,
      ).createShader(Rect.fromCircle(center: Offset(size.width / 2, size.height), radius: size.width / 2))
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
