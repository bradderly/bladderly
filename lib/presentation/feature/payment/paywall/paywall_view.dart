// Flutter imports:
// Project imports:
import 'dart:math';

import 'package:bladderly/domain/model/membership.dart';
import 'package:bladderly/domain/model/product.dart';
import 'package:bladderly/presentation/common/bloc/user_bloc.dart';
import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/util/text_size_util.dart';
import 'package:bladderly/presentation/common/widget/common_message_modal.dart';
import 'package:bladderly/presentation/common/widget/modal_app_bar.dart';
import 'package:bladderly/presentation/common/widget/primary_button.dart';
import 'package:bladderly/presentation/common/widget/progress_indicator_modal.dart';
import 'package:bladderly/presentation/feature/payment/bloc/payment_bloc.dart';
import 'package:bladderly/presentation/feature/payment/paywall/cubit/paywall_cubit.dart';
import 'package:bladderly/presentation/feature/payment/paywall/model/paywall_plan_model.dart';
import 'package:bladderly/presentation/feature/payment/paywall/model/paywall_plans_model.dart';
import 'package:bladderly/presentation/feature/payment/paywall/widget/paywall_plan_widget.dart';
import 'package:bladderly/presentation/feature/payment/promo_code/promo_code_builder.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';
import 'package:bladderly/presentation/router/route/about_route.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';
import 'package:bladderly/presentation/router/route/payment_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

abstract class PaywallView extends StatelessWidget {
  factory PaywallView({
    MembershipSubscription? subscription,
    required PaywallPlansModel plans,
  }) {
    if (subscription == null) return _FreeUserPaywallView(plans: plans);

    return _SubscriberPaywallView(subscription: subscription, plans: plans);
  }

  const PaywallView._({
    super.key,
    required this.subscription,
    required this.plans,
  });

  final MembershipSubscription? subscription;
  final PaywallPlansModel plans;

  void _purchase(BuildContext context) {
    final userId = context.read<UserBloc>().state.userModelOrThrowException.id;
    final planId = context.read<PaywallCubit>().state.selectedPlanId;

    context.read<PaymentBloc>().add(PaymentPurchasePlan(userId: userId, planId: planId!));
  }

  void _onReadySuccess(BuildContext context, PaymentPurchaseReadySuccess state) {
    context.pop();

    if (state.product == Product.threeDaysPass) {
      CommonMessageModal.show<void>(
        context,
        onTap: () => const PlanRoute().go(context),
        title: 'Surprise! A Gift for You!',
        content:
            'Enjoying our fresh new look? Here’s a free 3-day pass! Hope this helps you take care of your urinary health.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymentBloc, PaymentState>(
      listener: (context, state) => switch (state) {
        PaymentPurchaseReadyInProgress() => ProgressIndicatorModal.show(context),
        PaymentPurchaseReadySuccess() => _onReadySuccess(context, state),
        PaymentPurchaseReadyFailure() => context.pop(),
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
          appBar: ModalAppBar(
            backgroundColor: Colors.transparent,
            toolbarHeight: 45,
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    children: [
                      _buildHeader(context),
                      // Gap(this is _FreeUserPaywallView ? 24 : 24),
                      const Gap(24),
                      BlocSelector<PaywallCubit, PaywallState, String?>(
                        selector: (state) => state.selectedPlanId,
                        builder: (context, selectedPlanId) => _buildPlans(context, selectedPlanId: selectedPlanId),
                      ),
                      const Gap(24),
                      _buildPromo(context),
                      const Gap(24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 13),
                        child: Text(
                          'Your subscription renews automatically and can be canceled anytime.'
                              .tr(context)
                              .applyWordBreak(),
                          style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade6),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildFooter(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context);

  Widget _buildPlans(BuildContext context, {required String? selectedPlanId});

  Widget _buildPromo(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
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
                'Enter promo code'.tr(context),
                style: context.textStyleTheme.b14SemiBold.copyWith(
                  color: context.colorTheme.vermilion.primary.shade40,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      color: const Color(0xFFF8F8F7),
      child: Column(
        children: [
          const Gap(16),
          BlocSelector<PaywallCubit, PaywallState, bool>(
            selector: (state) => !state.isValid,
            builder: (context, isNotValid) => PrimaryButton.filled(
              onPressed: isNotValid ? null : () => _purchase(context),
              backgroundColor:
                  isNotValid ? context.colorTheme.neutral.shade6 : context.colorTheme.vermilion.primary.shade50,
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
    );
  }
}

class _FreeUserPaywallView extends PaywallView {
  const _FreeUserPaywallView({
    required super.plans,
  }) : super._(subscription: null);

  @override
  Widget _buildHeader(BuildContext context) {
    return Column(
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
            final textStyle = context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade10);

            final textWidth =
                texts.map((text) => TextSizeUtil.getSize(text: text, textStyle: textStyle).width).reduce(max);

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
    );
  }

  @override
  Widget _buildPlans(BuildContext context, {required String? selectedPlanId}) {
    return Column(
      children: [
        if (plans.threeDaysPass != null) ...[
          PaywallPlanWidget(
            onTap: (plan) => context.read<PaywallCubit>().selectPlan(plan.product.id),
            isSelected: selectedPlanId == plans.threeDaysPass!.product.id,
            plan: plans.threeDaysPass!,
          ),
          const Gap(24),
        ],
        ...List.generate(
          plans.withoutThreeDaysPass.length * 2 - 1,
          (index) {
            if (index.isOdd) return const Gap(12);

            final plan = plans.withoutThreeDaysPass[index ~/ 2];

            return PaywallPlanWidget(
              onTap: (plan) => context.read<PaywallCubit>().selectPlan(plan.product.id),
              isSelected: selectedPlanId == plan.product.id,
              plan: plan,
            );
          },
        ),
      ],
    );
  }
}

class _SubscriberPaywallView extends PaywallView {
  const _SubscriberPaywallView({
    required MembershipSubscription super.subscription,
    required super.plans,
  }) : super._();

  @override
  MembershipSubscription get subscription => super.subscription!;

  @override
  Widget _buildHeader(BuildContext context) {
    return Assets.icon.icPaymentDiamond.svg(width: 80, height: 80);
  }

  @override
  Widget _buildPlans(BuildContext context, {required String? selectedPlanId}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (plans.firstWhereByProduct(subscription.product) case final PaywallPlanModel plan) ...[
          Text(
            'Current plan'.tr(context),
            style: context.textStyleTheme.b16SemiBold.copyWith(color: context.colorTheme.neutral.shade10),
          ),
          const Gap(16),
          PaywallPlanWidget.my(plan: plan, renewAt: subscription.renewAt),
          const Gap(32),
        ],
        Text(
          'Offers for you'.tr(context),
          style: context.textStyleTheme.b16SemiBold.copyWith(color: context.colorTheme.neutral.shade10),
        ),
        const Gap(31),
        ...List.generate(
          plans.removeByProduct(subscription.product).length * 2 - 1,
          (index) {
            if (index.isOdd) return const Gap(12);

            final plan = plans.removeByProduct(subscription.product)[index ~/ 2];

            return PaywallPlanWidget(
              onTap: (plan) => context.read<PaywallCubit>().selectPlan(plan.product.id),
              isSelected: selectedPlanId == plan.product.id,
              plan: plan,
            );
          },
        ),
      ],
    );
  }
}
