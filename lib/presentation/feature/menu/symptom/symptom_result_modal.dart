// ignore: library_prefixes

// Dart imports:
import 'dart:math' as math;

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
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
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
                          const SizedBox(height: 40),
                          const GaugeWidget(
                            score: 13,
                            level: 'Mild2',
                            levelColor: Colors.green,
                            angle: 3.14 * (13 / 35),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Mild',
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
                              Column(
                                children: [
                                  Text(
                                    'Moderate',
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
                              Column(
                                children: [
                                  Text(
                                    'Severe',
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
                            ],
                          ),
                          const SizedBox(height: 40),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8.5),
                            height: 1,
                            color: context.colorTheme.neutral.shade5,
                          ),
                          const SizedBox(height: 40),
                          Text(
                            description,
                            textAlign: TextAlign.center,
                            style: context.textStyleTheme.b16Medium.copyWith(
                              color: context.colorTheme.neutral.shade10,
                            ),
                          ),
                          const SizedBox(height: 40),
                          Text(
                            'This is not a diagnosis. Consult with your doctor or medical professional if you have concerns about your condition.',
                            textAlign: TextAlign.center,
                            style: context.textStyleTheme.b14Medium.copyWith(
                              color: context.colorTheme.neutral.shade6,
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
  const GaugeWidget({
    super.key,
    required this.score,
    required this.level,
    required this.levelColor,
    required this.angle,
  });
  final int score;
  final String level;
  final Color levelColor;
  final double angle;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // 3가지 색상의 배경 원 테두리
        CustomPaint(
          size: const Size(200, 100),
          painter: BackgroundPainter(),
        ),
        // 현재 점수에 따른 진행 상태 (둥근 위치 표시 추가)
        CustomPaint(
          size: const Size(200, 100),
          painter: GaugePainter(angle: angle, levelColor: levelColor),
        ),
        // 점수와 레벨 텍스트
        Padding(
          padding: const EdgeInsets.only(top: 39),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$score',
                style: context.textStyleTheme.b28Bold.copyWith(color: const Color(0xFFFFC909)),
              ),
              Text(
                level,
                style: context.textStyleTheme.b28Bold.copyWith(color: const Color(0xFFFFC909)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// 기본 배경 원 테두리 그리기
class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final greenPaint = Paint()
      ..color = const Color(0xFF00BEA2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    final amberPaint = Paint()
      ..color = const Color(0xFFFFC909)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    final redPaint = Paint()
      ..color = const Color(0xFFFF6442)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    final arcRect = Rect.fromLTWH(0, 0, size.width, size.height * 2);

    // 배경 게이지 간격 추가
    canvas
      ..drawArc(
        arcRect,
        3.14,
        3.14 * (7 / 35) - 0.15,
        false,
        greenPaint,
      )
      ..drawArc(
        arcRect,
        3.14 + 3.14 * (7 / 35),
        3.14 * (12 / 35) - 0.15,
        false,
        amberPaint,
      )
      ..drawArc(
        arcRect,
        3.14 + 3.14 * (19 / 35),
        3.14 * (16 / 35) - 0.1,
        false,
        redPaint,
      );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

// 진행 상태를 나타내는 Paint
class GaugePainter extends CustomPainter {
  GaugePainter({required this.angle, required this.levelColor});
  final double angle;
  final Color levelColor;

  @override
  void paint(Canvas canvas, Size size) {
    final progressPaint = Paint()
      ..color = levelColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    final fillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // 현재 점수 위치를 둥근 원으로 표시
    final markerX = size.width / 2 + (size.width / 2) * math.cos(3.14 + angle);
    final markerY = size.height + (size.width / 2) * math.sin(3.14 + angle);

    canvas
      ..drawCircle(Offset(markerX, markerY), 10, fillPaint)
      ..drawCircle(
        Offset(markerX, markerY),
        10,
        progressPaint..style = PaintingStyle.stroke,
      );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
