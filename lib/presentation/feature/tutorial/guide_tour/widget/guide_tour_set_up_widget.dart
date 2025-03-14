import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/widget/modal_app_bar.dart';
import 'package:bladderly/presentation/feature/tutorial/guide_tour/widget/guide_tour_step_dot_widget.dart';
import 'package:bladderly/presentation/feature/tutorial/guide_tour/widget/guide_tour_step_row_widget.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gap/gap.dart';

class GuideTourSetUpWidget extends StatelessWidget {
  const GuideTourSetUpWidget({
    super.key,
  });

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
        const Gap(24),
        GestureDetector(
          onTap: () => showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            enableDrag: false,
            barrierColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            builder: (context) => Container(
              margin: EdgeInsets.only(top: MediaQuery.sizeOf(context).height * 0.05),
              color: Colors.transparent,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Scaffold(
                  appBar: ModalAppBar(
                    title: 'Bladder Diary'.tr(context),
                    backButton: false,
                  ),
                  body: SafeArea(
                    child: InAppWebView(
                      initialUrlRequest: URLRequest(
                        url: WebUri('https://www.bladderly.com/what-is-bladder-diary'),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          child: Text(
            'Tell me more about Bladder Diary'.tr(context),
            style: context.textStyleTheme.b14SemiBold.copyWith(
              color: context.colorTheme.vermilion.primary.shade50,
              decoration: TextDecoration.underline,
              decorationColor: context.colorTheme.vermilion.primary.shade50,
            ),
          ),
        ),
        const Gap(53),
        const GuideTourStepDotWidget(currentStep: 0, totalStep: 2),
      ],
    );
  }
}
