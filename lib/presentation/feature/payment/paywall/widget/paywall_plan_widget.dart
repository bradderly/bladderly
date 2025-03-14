import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/feature/payment/paywall/model/paywall_plan_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PaywallPlanWidget extends StatelessWidget {
  const PaywallPlanWidget({
    super.key,
    required this.onTap,
    required this.plan,
    required this.isSelected,
  });

  final ValueChanged<PaywallPlanModel> onTap;
  final bool isSelected;
  final PaywallPlanModel plan;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => onTap(plan),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: plan.isAnnualSubscription ? 24 : 20,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSelected ? context.colorTheme.vermilion.primary.shade50 : context.colorTheme.neutral.shade4,
                width: isSelected ? 2 : 1,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    plan.name.tr(context).applyWordBreak(),
                    style: context.textStyleTheme.b18Bold.copyWith(
                      color: context.colorTheme.neutral.shade10,
                    ),
                  ),
                ),
                const Gap(12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        if (plan.isDiscounted)
                          Text(
                            plan.originPrice,
                            style: context.textStyleTheme.b12SemiBold.copyWith(
                              color: context.colorTheme.neutral.shade9,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        const SizedBox(width: 5),
                        Text(
                          plan.price,
                          style: context.textStyleTheme.b20Bold.copyWith(
                            color: context.colorTheme.vermilion.primary.shade50,
                          ),
                        ),
                      ],
                    ),
                    if (plan.isAnnualSubscription)
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(text: plan.monthlyPrice),
                            const TextSpan(text: ' / '),
                            TextSpan(text: 'Month'.tr(context)),
                          ],
                          style: context.textStyleTheme.b12SemiBold.copyWith(
                            color: context.colorTheme.neutral.shade7,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (plan.isAnnualSubscription)
          Positioned(
            left: 17,
            top: -15,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: context.colorTheme.vermilion.primary.shade50,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Best Value'.tr(context),
                style: context.textStyleTheme.b12SemiBold.copyWith(
                  color: context.colorTheme.neutral.shade0,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
