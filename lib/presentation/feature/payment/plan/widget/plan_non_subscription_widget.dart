import 'dart:async';

import 'package:bladderly/domain/model/plan.dart';
import 'package:bladderly/presentation/common/bloc/plan_bloc.dart';
import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/widget/primary_button.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';
import 'package:bladderly/presentation/router/route/payment_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class PlanNonSubscriptionWidget extends StatelessWidget {
  const PlanNonSubscriptionWidget({super.key});

  Future<void> _onTapLearnMore(BuildContext context) async {
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Subscription details'.tr(context),
            style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade6),
          ),
          const Gap(8),
          Text(
            'Bladderly User'.tr(context),
            style: context.textStyleTheme.b20Bold.copyWith(color: context.colorTheme.neutral.shade10),
          ),
          const Gap(16),
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
                      style: context.textStyleTheme.b20Bold.copyWith(color: context.colorTheme.neutral.shade10),
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
                        style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade10),
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
                        style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade10),
                      ),
                    ),
                  ],
                ),
                const Gap(16),
                PrimaryButton.filled(
                  onPressed: () => _onTapLearnMore(context),
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
        ],
      ),
    );
  }
}
