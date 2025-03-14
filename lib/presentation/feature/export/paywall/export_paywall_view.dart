import 'package:bladderly/domain/model/plan.dart';
import 'package:bladderly/presentation/common/bloc/plan_bloc.dart';
import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/widget/common_error_modal.dart';
import 'package:bladderly/presentation/common/widget/modal_app_bar.dart';
import 'package:bladderly/presentation/common/widget/primary_button.dart';
import 'package:bladderly/presentation/feature/export/paywall/model/export_plan_model.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ExportPaywallView extends StatelessWidget {
  const ExportPaywallView({
    super.key,
    required Plan plan,
  }) : _plan = plan;

  final Plan _plan;

  ExportPlanModel get plan => ExportPlanModel.fromDomain(_plan);

  Future<void> _onNext(BuildContext context) async {
    await CommonErrorModal.show<bool>(
      context,
      onTap: context.pop,
      title: 'Surprise! A Gift for You!',
      content:
          'Loving our fresh new look? Enjoy a free export ticket on us! Hope this makes managing your urinary health even easier.',
    );

    if (context.mounted) context.pop<bool>(true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlanBloc, PlanState>(
      listener: (context, state) => switch (state) {
        PlanGetPlansSuccess() => PaywallRoute($extra: PaywallRouteExtra(plans: state.plans)).push<void>(context),
        _ => null,
      },
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFAD3BB), Color(0xFFF8F8F7)],
            stops: [0, 0.28],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: ModalAppBar(
            backgroundColor: Colors.transparent,
            backButton: false,
            toolbarHeight: 45,
          ),
          body: SafeArea(
            child: Stack(
              children: [
                ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  children: [
                    Assets.icon.icGuideTourExport.svg(),
                    const Gap(16),
                    Text(
                      'Diary Export',
                      style: context.textStyleTheme.b24Bold,
                      textAlign: TextAlign.center,
                    ),
                    const Gap(16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'A bladder diary with the selected data will be created as a PDF file and then sent via email.'
                            .tr(context)
                            .applyWordBreak(),
                        style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade10),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Gap(30),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: context.colorTheme.vermilion.primary.shade50,
                          width: 2,
                          strokeAlign: BorderSide.strokeAlignOutside,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              _plan.name,
                              style: context.textStyleTheme.b18Bold.copyWith(
                                color: context.colorTheme.neutral.shade10,
                              ),
                            ),
                          ),
                          const Gap(16),
                          Text(
                            plan.price,
                            style: context.textStyleTheme.b20Bold
                                .copyWith(color: context.colorTheme.vermilion.primary.shade50),
                          ),
                        ],
                      ),
                    ),
                    const Gap(24),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                      decoration: BoxDecoration(
                        color: context.colorTheme.neutral.shade0,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: context.colorTheme.neutral.shade4),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Assets.icon.icPaymentDiamond.svg(),
                              const Gap(16),
                              Text(
                                'Get Unlimited Access!'.tr(context),
                                style:
                                    context.textStyleTheme.b20Bold.copyWith(color: context.colorTheme.neutral.shade10),
                              ),
                            ],
                          ),
                          const Gap(12),
                          Row(
                            children: [
                              Icon(Icons.check, color: context.colorTheme.vermilion.primary.shade50, size: 20),
                              const Gap(6),
                              Expanded(
                                child: Text(
                                  'Automatic voiding volume measurement'.tr(context),
                                  style: context.textStyleTheme.b14Medium
                                      .copyWith(color: context.colorTheme.neutral.shade10),
                                ),
                              ),
                            ],
                          ),
                          const Gap(6),
                          Row(
                            children: [
                              Icon(Icons.check, color: context.colorTheme.vermilion.primary.shade50, size: 20),
                              const Gap(6),
                              Expanded(
                                child: Text(
                                  'PDF export reports'.tr(context),
                                  style: context.textStyleTheme.b14Medium
                                      .copyWith(color: context.colorTheme.neutral.shade10),
                                ),
                              ),
                            ],
                          ),
                          const Gap(16),
                          PrimaryButton.filled(
                            onPressed: () => context.read<PlanBloc>().add(const PlanGetPlans.subscription()),
                            shape: BoxShape.rectangle,
                            backgroundColor: context.colorTheme.vermilion.primary.shade50,
                            borderRadius: 30,
                            text: 'Learn more'.tr(context),
                            textColor: context.colorTheme.neutral.shade0,
                            size: const Size.fromHeight(48),
                          ),
                        ],
                      ),
                    ),
                    const Gap(183),
                  ],
                ),
                Positioned.fill(
                  top: null,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    color: const Color(0xFFF8F8F7),
                    child: Column(
                      children: [
                        const Gap(16),
                        PrimaryButton.filled(
                          onPressed: () => _onNext(context),
                          backgroundColor: context.colorTheme.vermilion.primary.shade50,
                          borderRadius: 400,
                          shape: BoxShape.rectangle,
                          text: 'Next'.tr(context),
                          textColor: context.colorTheme.neutral.shade0,
                          size: const Size.fromHeight(56),
                        ),
                        const Gap(24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () => const TermsRoute().push<void>(context),
                              child: Text(
                                'Terms of Use'.tr(context),
                                style: context.textStyleTheme.b14SemiBold.copyWith(
                                  color: context.colorTheme.neutral.shade6,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            const Gap(40),
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () => const PrivacyRoute().push<void>(context),
                              child: Text(
                                'Privacy Policy'.tr(context),
                                style: context.textStyleTheme.b14SemiBold.copyWith(
                                  color: context.colorTheme.neutral.shade6,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Gap(36),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
