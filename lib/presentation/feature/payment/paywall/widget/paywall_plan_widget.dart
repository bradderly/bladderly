import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/locale/app_locale.dart';
import 'package:bladderly/presentation/feature/payment/paywall/model/paywall_plan_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

abstract class PaywallPlanWidget extends StatelessWidget {
  const factory PaywallPlanWidget({
    required ValueChanged<PaywallPlanModel> onTap,
    required bool isSelected,
    required PaywallPlanModel plan,
  }) = _PaywallPlanWidget;

  const factory PaywallPlanWidget.my({
    required PaywallPlanModel plan,
    required DateTime? renewAt,
  }) = _MyPaywallPlanWidget;

  const PaywallPlanWidget._({
    required this.plan,
  });

  final PaywallPlanModel plan;

  BoxBorder? _border(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: plan.isAnnualSubscription ? 24 : 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: _border(context),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  plan.name.tr(context).applyWordBreak(),
                  style: context.textStyleTheme.b18Bold.copyWith(
                    color: context.colorTheme.neutral.shade10,
                  ),
                ),
                if (_buildRenwAt(context) case final Widget widget) widget,
              ],
            ),
          ),
          if (_buildPrice(context) case final Widget widget) widget,
        ],
      ),
    );
  }

  Widget? _buildPrice(BuildContext context) => null;

  Widget? _buildRenwAt(BuildContext context) => null;
}

class _PaywallPlanWidget extends PaywallPlanWidget {
  const _PaywallPlanWidget({
    required this.onTap,
    required this.isSelected,
    required super.plan,
  }) : super._();

  final ValueChanged<PaywallPlanModel> onTap;
  final bool isSelected;

  @override
  BoxBorder? _border(BuildContext context) => Border.all(
        color: isSelected ? context.colorTheme.vermilion.primary.shade50 : context.colorTheme.neutral.shade4,
        width: isSelected ? 2 : 1,
        strokeAlign: BorderSide.strokeAlignOutside,
      );

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => onTap(plan),
          child: super.build(context),
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

  @override
  Widget? _buildPrice(BuildContext context) {
    return Row(
      children: [
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
                    switch (context.locale) {
                      AppLocale.en => TextSpan(text: '${plan.monthlyPrice} / Month'),
                      AppLocale.ko => TextSpan(text: '매월 ${plan.monthlyPrice}'),
                    },
                  ],
                  style: context.textStyleTheme.b12SemiBold.copyWith(
                    color: context.colorTheme.neutral.shade7,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _MyPaywallPlanWidget extends PaywallPlanWidget {
  const _MyPaywallPlanWidget({
    required super.plan,
    required this.renewAt,
  }) : super._();

  final DateTime? renewAt;

  @override
  BoxBorder? _border(BuildContext context) => Border.all(
        color: context.colorTheme.neutral.shade4,
        strokeAlign: BorderSide.strokeAlignOutside,
      );

  @override
  Widget? _buildRenwAt(BuildContext context) {
    if (renewAt == null) return null;

    return Column(
      children: [
        const Gap(8),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(text: 'Next billing date on'.tr(context)),
              const TextSpan(text: ' '),
              TextSpan(
                text: switch (context.locale) {
                  AppLocale.en => DateFormat('MMMM dd, yyyy').format(renewAt!),
                  AppLocale.ko => DateFormat('yyyy년 M월 d일에 진행됩니다').format(renewAt!),
                },
              ),
            ],
            style: context.textStyleTheme.b12Medium.copyWith(color: context.colorTheme.neutral.shade6),
          ),
        ),
      ],
    );
  }
}
