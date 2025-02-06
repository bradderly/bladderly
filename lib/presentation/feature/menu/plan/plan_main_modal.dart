import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/extension/string_extension.dart';
import 'package:bradderly/presentation/feature/menu/widget/text_arrow.dart';
import 'package:bradderly/presentation/feature/menu/plan/cancel_plan_modal.dart';
import 'package:bradderly/presentation/feature/menu/plan/paywall_modal.dart';
import 'package:bradderly/presentation/feature/menu/plan/paywall_view.dart';
import 'package:bradderly/presentation/feature/menu/widget/modal_title.dart';
import 'package:bradderly/presentation/router/route/main_route.dart';
import 'package:bradderly/presentation/router/route/paywall_route.dart';
import 'package:flutter/material.dart';

class PlanMainModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      maxChildSize: 0.95,
      minChildSize: 0.95,
      builder: (_, controller) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 41),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  controller: controller,
                  children: [
                    ModalTitle(context, 'Plan'.tr(context)),
                    const SizedBox(height: 75.5),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        'Plan'.tr(context),
                        style:context.textStyleTheme.b14Medium.copyWith(
                            color: context.colorTheme.neutral.shade6),
                      ),
                    ),
                    Container(
                    height: 48,
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border(
                      bottom: BorderSide(
                        color: context.colorTheme.neutral.shade5,
                        width: 2,
                      ),
                      ),
                    ),
                    child: Text('Member'.tr(context),
                        style: context.textStyleTheme.b16Medium.copyWith(
                          color: context.colorTheme.neutral.shade10,
                        )),
                    ),
                    TextArrow(
                  title: "Change Plan".tr(context),
                  onTap: () {
                    //return const PaywallRoute().go(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PaywallView()),
                    );
                  }),
                    TextArrow(
                  title: "Cancel Plan".tr(context),
                  onTap: () {
                     showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return CancelPlanModal();
                          },
                        );
                  }),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 109, vertical: 12),
                decoration: BoxDecoration(
                  color: context.colorTheme.neutral.shade6,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text('Restore'.tr(context),
                    style: context.textStyleTheme.b16SemiBold.copyWith(
                      color: context.colorTheme.neutral.shade0,
                    )),
              )
            ],
          ),
        );
      },
    );
  }
}
