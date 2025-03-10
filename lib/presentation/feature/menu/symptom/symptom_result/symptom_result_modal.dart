// ignore: library_prefixes

// ignore_for_file: deprecated_member_use

// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/feature/menu/widget/modal_title.dart';

class SymptomResultModal extends StatelessWidget {
  const SymptomResultModal({
    super.key,
    // ignore: non_constant_identifier_names
    required this.symptom_type,
    required this.score,
    required this.status,
    required this.description,
    required this.dateTime,
  });
  // ignore: non_constant_identifier_names
  final String symptom_type;
  final int score;
  final String status;
  final String description;
  final String dateTime;

  @override
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.only(top: 40, bottom: 28),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  controller: controller,
                  children: [
                    // Title Section
                    ModalTitle(context, symptom_type),
                    const SizedBox(height: 39.5),

                    // Score Display Section
                    Center(
                      child: Column(
                        children: [
                          Text(
                            dateTime,
                            style: context.textStyleTheme.b16SemiBold.copyWith(
                              color: context.colorTheme.neutral.shade10,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '9:00 AM',
                            style: context.textStyleTheme.b14SemiBold.copyWith(
                              color: context.colorTheme.neutral.shade6,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 40),
                          Container(
                            width: 342,
                            height: 222,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF5D3F33).withOpacity(0.5),
                                  offset: const Offset(0, 2),
                                  blurRadius: 5,
                                ),
                                BoxShadow(
                                  color: const Color(0xFF5D3F33).withOpacity(0.5),
                                  offset: const Offset(0, 4),
                                  blurRadius: 8,
                                  spreadRadius: 3,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const GaugeWidget(score: 13),
                          ),
                          const SizedBox(height: 32),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: 1,
                                  height: 26,
                                  color: context.colorTheme.neutral.shade4,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Mild'.tr(context),
                                      style: context.textStyleTheme.b14SemiBold.copyWith(
                                        color: context.colorTheme.neutral.shade7,
                                      ),
                                    ),
                                    Text(
                                      '1-7',
                                      style: context.textStyleTheme.b14SemiBold.copyWith(
                                        color: context.colorTheme.neutral.shade7,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 1,
                                  height: 26,
                                  color: context.colorTheme.neutral.shade4,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Moderate'.tr(context),
                                      style: context.textStyleTheme.b14SemiBold.copyWith(
                                        color: context.colorTheme.neutral.shade7,
                                      ),
                                    ),
                                    Text(
                                      '8-19',
                                      style: context.textStyleTheme.b14SemiBold.copyWith(
                                        color: context.colorTheme.neutral.shade7,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 1,
                                  height: 26,
                                  color: context.colorTheme.neutral.shade4,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Severe'.tr(context),
                                      style: context.textStyleTheme.b14SemiBold.copyWith(
                                        color: context.colorTheme.neutral.shade7,
                                      ),
                                    ),
                                    Text(
                                      '20-35',
                                      style: context.textStyleTheme.b14SemiBold.copyWith(
                                        color: context.colorTheme.neutral.shade7,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 1,
                                  height: 26,
                                  color: context.colorTheme.neutral.shade4,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),
                          Container(
                            height: 94,
                            padding: const EdgeInsets.only(left: 24.5, right: 23.5),
                            child: Text(
                              description,
                              style: context.textStyleTheme.b16Medium.copyWith(
                                color: context.colorTheme.neutral.shade10,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            height: 69,
                            padding: const EdgeInsets.only(left: 24.5, right: 23.5),
                            child: Text(
                              'This is not a diagnosis. Consult with your doctor or medical professional if you have concerns about your condition.',
                              textAlign: TextAlign.center,
                              style: context.textStyleTheme.b14Medium.copyWith(
                                color: context.colorTheme.neutral.shade6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 109, vertical: 12),
                  decoration: BoxDecoration(
                    color: context.colorTheme.vermilion.primary.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Okay'.tr(context),
                    style: context.textStyleTheme.b16SemiBold.copyWith(
                      color: context.colorTheme.neutral.shade0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }
}

class GaugeWidget extends StatelessWidget {
  const GaugeWidget({super.key, required this.score});
  final int score;
  final int maxScore = 35;

  Map<String, dynamic> getStatus() {
    if (score == 0) {
      return {'text': 'No Symptom', 'face': 'img_symptom_face_1.png', 'color': const Color(0xFF94A22F)};
    } else if (score <= 7) {
      return {'text': 'Mild', 'face': 'img_symptom_face_2.png', 'color': const Color(0xFF94A22F)};
    } else if (score <= 20) {
      return {'text': 'Modarate', 'face': 'img_symptom_face_3.png', 'color': const Color(0xFFFF8D38)};
    } else {
      return {'text': 'Severe', 'face': 'img_symptom_face_4.png', 'color': const Color(0xFFFF6442)};
    }
  }

  @override
  Widget build(BuildContext context) {
    final percentage = score / maxScore;
    final status = getStatus();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            CustomPaint(
              size: const Size(220, 110),
              painter: GaugePainter(percentage),
            ),
            Positioned(
              bottom: 0,
              left: (220 - 50) / 2, // Center the image horizontally
              child: Image.asset(
                'assets/img/${status['face']}',
                width: 50,
                height: 50,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          status['text'].toString().tr(context),
          style: context.textStyleTheme.b20Bold.copyWith(
            color: status['color'] as Color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Score:'.tr(context) + score.toString(),
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
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..shader = const SweepGradient(
        colors: [Color(0xFF94A22F), Color(0xFFD97A3B), Color(0xFFFF6442)],
        stops: [0.0, 0.2, 1.0],
        startAngle: pi,
      ).createShader(Rect.fromCircle(center: Offset(size.width / 2, size.height), radius: size.width / 2))
      ..strokeWidth = 12
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
