import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class GuideTourStepDotWidget extends StatelessWidget {
  const GuideTourStepDotWidget({
    super.key,
    required this.currentStep,
    required this.totalStep,
  });

  final int currentStep;
  final int totalStep;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        totalStep * 2 - 1,
        (index) {
          if (index.isOdd) return const Gap(12);
          return Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: index ~/ 2 == currentStep
                  ? context.colorTheme.vermilion.primary.shade50
                  : context.colorTheme.neutral.shade4,
              shape: BoxShape.circle,
            ),
          );
        },
      ),
    );
  }
}
