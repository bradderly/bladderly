// Flutter imports:

// Project imports:
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/feature/menu/utils/modal_helper.dart';
import 'package:bladderly/presentation/feature/menu/widget/modal_title.dart';
import 'package:bladderly/presentation/feature/menu/widget/text_arrow_form.dart';
import 'package:bladderly/presentation/feature/plan/plan_cancel/plan_cancel_builder.dart';
import 'package:bladderly/presentation/feature/plan/promo_code/promo_code_modal.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';
// Flutter imports:
import 'package:flutter/material.dart';

class PlanModal extends StatelessWidget {
  const PlanModal({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      maxChildSize: 0.95,
      minChildSize: 0.95,
      builder: (_, controller) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 41),
          child: Column(
            children: [
              ModalTitle(context, 'Plan'.tr(context)),
              const SizedBox(height: 42),
              Expanded(
                child: ListView(
                  controller: controller,
                  children: [
                    FreeUser(context),
                    //      NonFreeUser(context),
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.only(left: 24),
                      child: Text(
                        'Setting plan'.tr(context),
                        style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade6),
                      ),
                    ),

                    TextArrow(
                      title: 'Change plan'.tr(context),
                      onTap: () {
                        return const PaywallRoute().go(context);
                        /*
                          Navigator.push(
                            context,
                            // ignore: inference_failure_on_instance_creation
                            MaterialPageRoute(
                              builder: (context) => const PaywallBuilder(),
                            ),
                          );
                          */
                      },
                    ),
                    TextArrow(
                      title: 'Cancel plan'.tr(context),
                      onTap: () => ModalHelper.showModal(
                        context: context,
                        modalBuilder: (_) => const PlanCancelBuilder(),
                        duration: 5,
                      ),
                    ),
                    TextArrow(
                      title: 'Enter Promo Code'.tr(context),
                      onTap: () => ModalHelper.showModal(
                        context: context,
                        modalBuilder: (_) => const PromoCodeModal(),
                        duration: 5,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 109, vertical: 12),
                decoration: BoxDecoration(
                  color: context.colorTheme.neutral.shade6,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Retrieve purchase data'.tr(context),
                  style: context.textStyleTheme.b16SemiBold.copyWith(
                    color: context.colorTheme.neutral.shade0,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ignore: non_constant_identifier_names
Widget FreeUser(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 24, right: 21),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Subscription details'.tr(context),
          style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade6),
        ),
        const SizedBox(height: 8),
        Text(
          'Bladderly User'.tr(context),
          style: context.textStyleTheme.b20Bold.copyWith(color: context.colorTheme.neutral.shade10),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(Icons.diamond_outlined, color: context.colorTheme.vermilion.primary.shade50, size: 40),
                  const SizedBox(width: 16),
                  Text(
                    'Get Unlimited Access!'.tr(context),
                    style: context.textStyleTheme.b20Bold.copyWith(color: context.colorTheme.neutral.shade10),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.check, color: context.colorTheme.vermilion.primary.shade50, size: 20),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Automatic voiding volume measurement'.tr(context),
                      style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade10),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Icon(Icons.check, color: context.colorTheme.vermilion.primary.shade50, size: 20),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'PDF export reports'.tr(context),
                      style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade10),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
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

// ignore: non_constant_identifier_names
Widget NonFreeUser(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 24, right: 21),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Subscription details'.tr(context),
          style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade6),
        ),
        const SizedBox(height: 8),

        Row(
          children: [
            Icon(Icons.diamond_outlined, color: context.colorTheme.vermilion.primary.shade50, size: 20),
            const SizedBox(width: 6),
            Text(
              'Free trial'.tr(context),
              style: context.textStyleTheme.b20Bold.copyWith(color: context.colorTheme.neutral.shade10),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Free Trial Period Container
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: context.colorTheme.white.shade20,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Free Trial Period'.tr(context),
                style: context.textStyleTheme.b16SemiBold.copyWith(color: context.colorTheme.neutral.shade10),
              ),
              const SizedBox(height: 6),
              Divider(color: context.colorTheme.neutral.shade5),
              const SizedBox(height: 10),

              // Trial Start date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Trial Start date'.tr(context),
                    style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade7),
                  ),
                  Text(
                    'Jan 1st, 2025',
                    style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade7),
                  ),
                ],
              ),
              const SizedBox(height: 6),

              // Trial End date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Trial End date'.tr(context),
                    style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade7),
                  ),
                  Text(
                    'Jan 4th, 2025',
                    style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade7),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Benefits 섹션
        Text(
          'Benefits'.tr(context),
          style: context.textStyleTheme.b16SemiBold.copyWith(color: context.colorTheme.neutral.shade10),
        ),
        const SizedBox(height: 12),

        // 혜택 리스트
        Row(
          children: [
            Icon(Icons.check, color: context.colorTheme.vermilion.primary.shade50, size: 20),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                'Automatic voiding volume measurement'.tr(context),
                style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade10),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),

        Row(
          children: [
            Icon(Icons.check, color: context.colorTheme.vermilion.primary.shade50, size: 20),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                'PDF export reports'.tr(context),
                style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade10),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
