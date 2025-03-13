import 'package:bladderly/presentation/common/cubit/main_tab_cubit.dart';
import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/widget/primary_button.dart';
import 'package:bladderly/presentation/feature/tutorial/guide_tour/widget/guide_tour_step_dot_widget.dart';
import 'package:bladderly/presentation/feature/tutorial/guide_tour/widget/guide_tour_step_row_widget.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class GuideTourExportWidget extends StatelessWidget {
  const GuideTourExportWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Assets.icon.icGuideTourExport.svg(),
        const Gap(16),
        SizedBox(
          width: 202,
          child: Text(
            'Need a printed copy of your logs?'.tr(context),
            style: context.textStyleTheme.b20Bold.copyWith(color: context.colorTheme.neutral.shade10),
            textAlign: TextAlign.center,
          ),
        ),
        const Gap(16),
        IntrinsicWidth(
          child: Column(
            children: [
              GuideTourStepRowWidget(
                step: 3,
                text: 'You can export PDF'.tr(context),
              ),
              const Gap(32),
              PrimaryButton.filled(
                onPressed: () => context
                  ..read<MainTabCubit>().showHome()
                  ..pop(),
                backgroundColor: context.colorTheme.vermilion.primary.shade50,
                borderRadius: 400,
                shape: BoxShape.rectangle,
                text: 'Let’s go!'.tr(context),
                textColor: context.colorTheme.neutral.shade0,
                size: const Size.fromHeight(52),
              ),
            ],
          ),
        ),
        const Gap(38),
        const GuideTourStepDotWidget(currentStep: 1, totalStep: 2),
      ],
    );
  }
}
