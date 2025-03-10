// Flutter imports:
// Project imports:
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/util/text_size_util.dart';
import 'package:bladderly/presentation/common/widget/modal_app_bar.dart';
import 'package:bladderly/presentation/common/widget/primary_button.dart';
import 'package:bladderly/presentation/common/widget/progress_indicator_modal.dart';
import 'package:bladderly/presentation/feature/payment/bloc/payment_bloc.dart';
import 'package:bladderly/presentation/feature/payment/paywall/cubit/paywall_cubit.dart';
import 'package:bladderly/presentation/feature/payment/paywall/model/paywall_plans_model.dart';
import 'package:bladderly/presentation/feature/payment/paywall/widget/paywall_plan_widget.dart';
import 'package:bladderly/presentation/feature/payment/promo_code/promo_code_builder.dart';
import 'package:bladderly/presentation/feature/payment/promo_code/promo_code_modal.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class PaywallView extends StatefulWidget {
  const PaywallView({
    super.key,
    required this.plans,
  });

  final PaywallPlansModel plans;

  @override
  State<PaywallView> createState() => _PaywallViewState();
}

class _PaywallViewState extends State<PaywallView> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymentBloc, PaymentState>(
      listenWhen: (_, state) {
        return true;
      },
      listener: (context, state) => switch (state) {
        PaymentPurchaseReadyInProgress() => ProgressIndicatorModal.show(context),
        PaymentPurchaseSuccess() => context.pop(),
        PaymentPurchaseFailure() => context.pop(),
        PaymentPurchaseRestored() => context.pop(),
        PaymentPurchaseCanceled() => context.pop(),
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
          body: SafeArea(
            child: Stack(
              fit: StackFit.expand,
              children: [
                ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  children: [
                    const Gap(92),
                    Column(
                      children: [
                        Assets.icon.icPaymentDiamond.svg(
                          width: 80,
                          height: 80,
                        ),
                        const Gap(16),
                        Text(
                          'Get Unlimited Access!'.tr(context),
                          style: context.textStyleTheme.b24BoldOutfit.copyWith(
                            color: context.colorTheme.neutral.shade10,
                          ),
                        ),
                        const Gap(8),
                        Builder(
                          builder: (context) {
                            final texts = [
                              'Automatic voiding volume measurement'.tr(context),
                              'PDF export reports'.tr(context),
                            ];
                            final textStyle =
                                context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade10);

                            final textWidth = texts
                                .map((text) => TextSizeUtil.getSize(text: text, textStyle: textStyle))
                                .reduce((value, element) => value.width > element.width ? value : element)
                                .width;

                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
                                  for (final text in texts)
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Assets.icon.icPaymentCheck.svg(),
                                        const Gap(8),
                                        Flexible(
                                          child: ConstrainedBox(
                                            constraints: BoxConstraints(minWidth: textWidth),
                                            child: Text(
                                              text,
                                              style: context.textStyleTheme.b14Medium.copyWith(
                                                color: context.colorTheme.neutral.shade10,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const Gap(40),
                    BlocSelector<PaywallCubit, PaywallState, String?>(
                      selector: (state) => state.selectedPlanId,
                      builder: (context, selectedPlanId) => Column(
                        children: List.generate(
                          widget.plans.length * 2 - 1,
                          (index) {
                            if (index.isOdd) return const Gap(12);

                            final plan = widget.plans[index ~/ 2];

                            return PaywallPlanWidget(
                              onTap: (plan) => context.read<PaywallCubit>().selectPlan(plan.id),
                              isSelected: selectedPlanId == plan.id,
                              plan: plan,
                            );
                          },
                        ),
                      ),
                    ),
                    const Gap(24),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () => showModalBottomSheet<void>(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => const PromoCodeBuilder(),
                          ),
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: context.colorTheme.vermilion.primary.shade40)),
                              ),
                              child: Text(
                                'Enter Promo Code'.tr(context),
                                style: context.textStyleTheme.b14SemiBold.copyWith(
                                  color: context.colorTheme.vermilion.primary.shade40,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(32),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13),
                      child: Text(
                        'Your monthly or annual subscription automatically renews for the same term unless canceled.'
                            .tr(context)
                            .applyWordBreak(),
                        style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade6),
                        textAlign: TextAlign.center,
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
                        BlocSelector<PaywallCubit, PaywallState, bool>(
                          selector: (state) => !state.isValid,
                          builder: (context, isNotValid) => PrimaryButton.filled(
                            onPressed: isNotValid
                                ? null
                                : () => context.read<PaymentBloc>().add(
                                      PaymentPurchasePlan(planId: context.read<PaywallCubit>().state.selectedPlanId!),
                                    ),
                            backgroundColor: context.colorTheme.vermilion.primary.shade50,
                            borderRadius: 400,
                            shape: BoxShape.rectangle,
                            text: 'Next'.tr(context),
                            textColor: context.colorTheme.neutral.shade0,
                            size: const Size.fromHeight(56),
                          ),
                        ),
                        const Gap(24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
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
                Positioned.fill(
                  bottom: null,
                  child: ModalAppBar(
                    title: '',
                    backgroundColor: Colors.transparent,
                    backButton: false,
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
