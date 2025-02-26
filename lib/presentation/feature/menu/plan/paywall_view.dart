import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/extension/string_extension.dart';
import 'package:bradderly/presentation/feature/menu/plan/promo_code_modal.dart';
import 'package:bradderly/presentation/feature/menu/plan/terms_view.dart';
import 'package:bradderly/presentation/feature/menu/plan/privacy_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PaywallView extends StatefulWidget {
  const PaywallView({super.key});

  @override
  State<PaywallView> createState() => _PaywallViewState();
}

class _PaywallViewState extends State<PaywallView> {
  String clickItem = '';
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: context.colorTheme.neutral.shade2,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 22),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Icon(Icons.diamond_outlined, color: context.colorTheme.vermilion.primary.shade50, size: 80),
              const SizedBox(height: 16),
              Text(
                'Get Unlimited Access!'.tr(context),
                style: context.textStyleTheme.b24BoldOutfit.copyWith(
                  color: context.colorTheme.neutral.shade10,
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.check, color: context.colorTheme.vermilion.primary.shade50),
                        const SizedBox(width: 8),
                        Text(
                          'Automatic Voiding Volume Measurement'.tr(context),
                          style: context.textStyleTheme.b14Medium.copyWith(
                            color: context.colorTheme.neutral.shade10,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.check, color: context.colorTheme.vermilion.primary.shade50),
                        const SizedBox(width: 8),
                        Text(
                          'PDF Export reports'.tr(context),
                          style: context.textStyleTheme.b14Medium.copyWith(
                            color: context.colorTheme.neutral.shade10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              _buildPlanCard(context, '3-Day Pass', r'$2.99'),
              const SizedBox(height: 24),
              _buildPlanCard(context, 'Annual', r'$24.99', r'$59.88', '2.08', true),
              const SizedBox(height: 12),
              _buildPlanCard(context, 'Monthly', r'$4.99'),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  // ignore: inference_failure_on_function_invocation
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      return const PromoCodeModal();
                    },
                  );
                },
                child: Text(
                  'Enter Promo Code'.tr(context),
                  style: context.textStyleTheme.b14SemiBold.copyWith(
                    color: context.colorTheme.vermilion.primary.shade40,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Text(
                  'Your monthly or annual subscription automatically renews for the same term unless canceled.'
                      .tr(context),
                  style: context.textStyleTheme.b14SemiBold.copyWith(
                    color: context.colorTheme.neutral.shade7,
                    decoration: TextDecoration.underline,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: (clickItem != '')
                        ? context.colorTheme.vermilion.primary.shade50
                        : context.colorTheme.neutral.shade6,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(400),
                    ),
                  ),
                  onPressed: () {
                    if (clickItem != '') {
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text(
                    'Next'.tr(context),
                    style: context.textStyleTheme.b16SemiBold.copyWith(
                      color: context.colorTheme.neutral.shade0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        // ignore: inference_failure_on_instance_creation
                        MaterialPageRoute(
                          builder: (context) => const TermsView(),
                        ),
                      );
                    },
                    child: Text(
                      'Terms of Use'.tr(context),
                      style: context.textStyleTheme.b14SemiBold.copyWith(
                        color: context.colorTheme.neutral.shade6,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        // ignore: inference_failure_on_instance_creation
                        MaterialPageRoute(
                          builder: (context) => const PrivacyView(),
                        ),
                      );
                    },
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
              const SizedBox(height: 36),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlanCard(
    BuildContext context,
    String title,
    String price, [
    String? oldPrice,
    String? monthPrice,
    bool isBestValue = false,
  ]) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              clickItem = title;
            });
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 22),
            padding: const EdgeInsets.only(left: 24, top: 14, right: 24, bottom: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: (clickItem == title)
                    ? context.colorTheme.vermilion.primary.shade50
                    : context.colorTheme.neutral.shade4,
                width: (clickItem == title) ? 2 : 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title.tr(context),
                      style: context.textStyleTheme.b18Bold.copyWith(
                        color: context.colorTheme.neutral.shade10,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            if (oldPrice != null)
                              Text(
                                oldPrice,
                                style: context.textStyleTheme.b12SemiBold.copyWith(
                                  color: context.colorTheme.neutral.shade9,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            const SizedBox(width: 5),
                            Text(
                              price,
                              style: context.textStyleTheme.b20Bold.copyWith(
                                color: context.colorTheme.vermilion.primary.shade50,
                              ),
                            ),
                          ],
                        ),
                        if (monthPrice != null)
                          Text(
                            r'$' + monthPrice + ' / Month', // ignore: prefer_interpolation_to_compose_strings
                            style: context.textStyleTheme.b12SemiBold.copyWith(
                              color: context.colorTheme.neutral.shade7,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (isBestValue)
          Positioned(
            top: -10,
            left: 40,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: context.colorTheme.vermilion.primary.shade50,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Best Value'.tr(context),
                style: context.textStyleTheme.b12Medium.copyWith(
                  color: context.colorTheme.neutral.shade0,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
