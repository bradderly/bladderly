import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/widget/primary_button.dart';
import 'package:bladderly/presentation/feature/tutorial/guide_tour/widget/guide_tour_step_row_widget.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class GuideTourSetUpWidget extends StatelessWidget {
  const GuideTourSetUpWidget({
    super.key,
    required this.onNext,
  });

  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Assets.icon.icGuideTourSetUp.svg(),
        const Gap(24),
        Text(
          'Let’s Get You Set Up!'.tr(context),
          style: context.textStyleTheme.b20Bold.copyWith(color: context.colorTheme.neutral.shade10),
        ),
        const Gap(24),
        IntrinsicWidth(
          child: Column(
            children: List.generate(
              3,
              (index) {
                if (index.isOdd) return const Gap(8);
                return GuideTourStepRowWidget(
                  step: index ~/ 2 + 1,
                  text: ['Log intake & voiding', 'Check your diary'][index ~/ 2].tr(context),
                );
              },
            ),
          ),
        ),
        const Gap(44),
        PrimaryButton.filled(
          onPressed: onNext,
          backgroundColor: context.colorTheme.vermilion.primary.shade50,
          borderRadius: 400,
          shape: BoxShape.rectangle,
          text: 'Next'.tr(context),
          textColor: context.colorTheme.neutral.shade0,
          size: const Size.fromHeight(52),
        ),
      ],
    );
  }
}
