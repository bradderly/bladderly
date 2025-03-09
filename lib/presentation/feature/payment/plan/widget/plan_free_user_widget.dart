import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PlanFreeUserWidget extends StatelessWidget {
  const PlanFreeUserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 21),
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
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: context.colorTheme.vermilion.primary.shade50,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Learn more'.tr(context),
                    style: context.textStyleTheme.b16SemiBold.copyWith(color: context.colorTheme.neutral.shade0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
