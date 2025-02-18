import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/extension/string_extension.dart';
import 'package:bradderly/presentation/feature/menu/plan/terms_view.dart';
import 'package:bradderly/presentation/feature/menu/plan/privacy_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PaywallView extends StatelessWidget {
  const PaywallView({super.key});

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
              const SizedBox(height: 38),
              Text(
                'Get Unlimited Access!'.tr(context),
                style: context.textStyleTheme.b24BoldOutfit.copyWith(
                  color: context.colorTheme.neutral.shade10,
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(left: 34, right: 30),
                child: Text(
                  'Subscribe for the automatic voided volume measuring feature.'
                      .tr(context),
                  textAlign: TextAlign.center,
                  style: context.textStyleTheme.b16Medium.copyWith(
                    color: context.colorTheme.neutral.shade10,
                  ),
                ),
              ),
              const SizedBox(height: 48),
              // 연간 요금제 카드
              Container(
                margin: const EdgeInsets.only(left: 26, right: 22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: context.colorTheme.neutral.shade5),
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 8,
                      ),
                      decoration: BoxDecoration(
                        color: context.colorTheme.vermilion.primary.shade50,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Best Value'.tr(context),
                        style: context.textStyleTheme.b12Medium.copyWith(
                          color: context.colorTheme.neutral.shade0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 24,
                        top: 24,
                        right: 24,
                        bottom: 24,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Annual'.tr(context),
                                style: context.textStyleTheme.b24Bold.copyWith(
                                  color: context.colorTheme.neutral.shade10,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '\$2.08 / ${'Month'.tr(context)}',
                                style:
                                    context.textStyleTheme.b12SemiBold.copyWith(
                                  color: context.colorTheme.neutral.shade9,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                r'$59.88',
                                style:
                                    context.textStyleTheme.b12SemiBold.copyWith(
                                  color: context.colorTheme.neutral.shade9,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                r'$24.99',
                                style: context.textStyleTheme.b20Bold.copyWith(
                                  color: context
                                      .colorTheme.vermilion.primary.shade50,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // 월간 요금제 카드
              Container(
                margin: const EdgeInsets.only(left: 26, right: 22),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: context.colorTheme.neutral.shade5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Monthly'.tr(context),
                      style: context.textStyleTheme.b24Bold.copyWith(
                        color: context.colorTheme.neutral.shade10,
                      ),
                    ),
                    Text(
                      r'$4.99',
                      style: context.textStyleTheme.b20Bold.copyWith(
                        color: context.colorTheme.vermilion.primary.shade50,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              Text(
                'Enter Promo Code'.tr(context),
                style: context.textStyleTheme.b14SemiBold.copyWith(
                  color: context.colorTheme.vermilion.primary.shade40,
                  decoration: TextDecoration.underline,
                  decorationColor: context.colorTheme.vermilion.primary.shade40,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Study Code'.tr(context),
                style: context.textStyleTheme.b14SemiBold.copyWith(
                  color: context.colorTheme.vermilion.primary.shade40,
                  decoration: TextDecoration.underline,
                  decorationColor: context.colorTheme.vermilion.primary.shade40,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 22),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.colorTheme.neutral.shade6,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(400),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Start with your 7-days free trial'.tr(context),
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
                      //return const PaywallRoute().go(context);
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
                        color: context.colorTheme.neutral.shade7,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                  GestureDetector(
                    onTap: () {
                      //return const PaywallRoute().go(context);
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
                        color: context.colorTheme.neutral.shade7,
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
}
