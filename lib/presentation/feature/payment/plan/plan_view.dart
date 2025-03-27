// Flutter imports:

import 'dart:async';

import 'package:bladderly/domain/model/membership.dart';
import 'package:bladderly/domain/model/plan.dart';
import 'package:bladderly/presentation/common/bloc/membership_bloc.dart';
import 'package:bladderly/presentation/common/bloc/plan_bloc.dart';
import 'package:bladderly/presentation/common/cubit/timer_cubit.dart';
// Project imports:
import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/widget/modal_app_bar.dart';
import 'package:bladderly/presentation/common/widget/primary_button.dart';
import 'package:bladderly/presentation/feature/menu/widget/text_arrow_form.dart';
import 'package:bladderly/presentation/feature/payment/bloc/payment_bloc.dart';
import 'package:bladderly/presentation/feature/payment/plan/widget/plan_non_subscription_widget.dart';
import 'package:bladderly/presentation/feature/payment/plan/widget/plan_subscription_widget.dart';
import 'package:bladderly/presentation/feature/payment/plan_cancel/plan_cancel_modal.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';
import 'package:bladderly/presentation/router/route/payment_route.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class PlanView extends StatelessWidget {
  const PlanView({super.key});

  Future<void> _onTapChangePlan(BuildContext context) async {
    final completer = Completer<List<Plan>>();
    context.read<PlanBloc>().add(PlanGetPlans.subscription(completer: completer));

    return completer.future
        .then(
          (plans) => context.mounted ? PaywallRoute($extra: PaywallRouteExtra(plans: plans)).push<void>(context) : null,
        )
        .onError((error, stackTrace) => null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ModalAppBar(title: 'Plan'.tr(context)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Stack(
            fit: StackFit.expand,
            children: [
              ListView(
                controller: ModalScrollController.of(context),
                physics: const ClampingScrollPhysics(),
                children: [
                  BlocSelector<TimerCubit, DateTime, MembershipSubscription?>(
                    selector: (state) => context.read<MembershipBloc>().state.membership?.subscription,
                    builder: (context, subscription) {
                      if (subscription case final MembershipSubscription subscription when subscription.isValid) {
                        return PlanSubscriptionWidget(subscription: subscription);
                      }

                      return const PlanNonSubscriptionWidget();
                    },
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Text(
                      'Setting plan'.tr(context),
                      style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade6),
                    ),
                  ),
                  BlocSelector<TimerCubit, DateTime, MembershipSubscription?>(
                    selector: (state) => context.read<MembershipBloc>().state.membership?.subscription,
                    builder: (context, subscription) {
                      if (subscription case final MembershipSubscription subscription when subscription.isValid) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextArrow(
                              onTap: () => _onTapChangePlan(context),
                              title: 'Change plan'.tr(context),
                            ),
                            TextArrow(
                              onTap: () => PlanCancelView.show(context),
                              title: 'Cancel plan'.tr(context),
                            ),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  TextArrow(
                    title: 'Enter promo code'.tr(context),
                    onTap: () => const PlanPromoCodeRoute().go(context),
                  ),
                  const Gap(130),
                ],
              ),
              Positioned.fill(
                top: null,
                bottom: 40,
                left: 16,
                right: 16,
                child: PrimaryButton.filled(
                  onPressed: () => context.read<PaymentBloc>().add(const PaymentRestorePlan()),
                  backgroundColor: context.colorTheme.vermilion.primary.shade50,
                  borderRadius: 8,
                  shape: BoxShape.rectangle,
                  text: 'Retrieve purchase data'.tr(context),
                  textColor: context.colorTheme.neutral.shade0,
                  size: const Size.fromHeight(43),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
