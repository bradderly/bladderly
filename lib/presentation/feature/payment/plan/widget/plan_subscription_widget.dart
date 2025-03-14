import 'package:bladderly/domain/model/membership.dart';
import 'package:bladderly/domain/model/product.dart';
import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class PlanSubscriptionWidget extends StatelessWidget {
  const PlanSubscriptionWidget({
    super.key,
    required this.subscription,
  });

  final MembershipSubscription subscription;

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
          Row(
            children: [
              Assets.icon.icPaymentDiamond.svg(width: 24, height: 24),
              const Gap(5),
              Expanded(
                child: Text(
                  switch (subscription.product) {
                    Product.oneDayFreeTrial => 'Free trial'.tr(context),
                    Product.threeDaysPass => '3-Day Pass'.tr(context),
                    Product.monthlySubscription => 'Monthly subscriber'.tr(context),
                    Product.annualSubscription => 'Annual subscriber'.tr(context),
                    _ => throw UnsupportedError('Unsupported product: ${subscription.product}'),
                  },
                  style: context.textStyleTheme.b20Bold.copyWith(color: context.colorTheme.neutral.shade10),
                ),
              ),
            ],
          ),
          const Gap(16),
          _buildSubscriptionDetails(context),
          const Gap(24),
          Text(
            'Benefits'.tr(context),
            style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade6),
          ),
          const Gap(8),
          ...List.generate(2, (index) {
            return Row(
              children: [
                Assets.icon.icPaymentCheck.svg(),
                const Gap(4),
                Text(
                  ['Automatic voiding volume measurement', 'Unlimited PDF export'][index].tr(context),
                  style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade10),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSubscriptionDetails(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colorTheme.neutral.shade2,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            switch (subscription.product) {
              Product.oneDayFreeTrial => 'Free Trial Period'.tr(context),
              Product.threeDaysPass => '3-Day Pass'.tr(context),
              Product.monthlySubscription => 'Monthly subscriber'.tr(context),
              Product.annualSubscription => 'Annual subscriber'.tr(context),
              _ => throw UnsupportedError('Unsupported product: ${subscription.product}'),
            },
            style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade10),
          ),
          const Gap(10),
          Divider(color: context.colorTheme.neutral.shade4, thickness: 1, height: 1),
          const Gap(12),
          Row(
            children: [
              Expanded(
                child: Text(
                  subscription.product == Product.oneDayFreeTrial
                      ? 'Trial Start date'.tr(context)
                      : 'Start date'.tr(context),
                  style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade7),
                ),
              ),
              const Gap(16),
              Text(
                DateFormat('MMMM d, yyyy').format(subscription.startDate),
                style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade7),
              ),
            ],
          ),
          const Gap(10),
          Row(
            children: [
              Expanded(
                child: Text(
                  subscription.product == Product.oneDayFreeTrial
                      ? 'Trial End date'.tr(context)
                      : 'End date'.tr(context),
                  style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade7),
                ),
              ),
              const Gap(16),
              Text(
                DateFormat('MMMM d, yyyy').format(subscription.endDate),
                style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade7),
              ),
            ],
          ),
          if (subscription.renewAt case final DateTime renewAt when renewAt.isAfter(DateTime.now())) ...[
            const Gap(12),
            Divider(color: context.colorTheme.neutral.shade4, thickness: 1, height: 1),
            const Gap(10),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Next renewal date '.tr(context),
                    style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade7),
                  ),
                ),
                const Gap(16),
                Text(
                  DateFormat('MMMM d, yyyy').format(DateTime.now()),
                  style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade7),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
