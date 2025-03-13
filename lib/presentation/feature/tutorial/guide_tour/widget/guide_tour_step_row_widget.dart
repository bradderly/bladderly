import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class GuideTourStepRowWidget extends StatelessWidget {
  const GuideTourStepRowWidget({
    super.key,
    required this.step,
    required this.text,
  });

  final int step;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            border: Border.all(
              color: context.colorTheme.vermilion.primary.shade50,
              width: 2,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Text(
            'Step $step'.tr(context),
            style: context.textStyleTheme.b12SemiBold.copyWith(color: context.colorTheme.vermilion.primary.shade50),
          ),
        ),
        const Gap(8),
        Text(
          text.tr(context),
          style: context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade10),
        ),
        const Gap(17),
      ],
    );
  }
}
