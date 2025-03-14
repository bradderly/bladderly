// Flutter imports:

import 'package:bladderly/presentation/common/bloc/plan_bloc.dart';
// Project imports:
import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/widget/modal_app_bar.dart';
import 'package:bladderly/presentation/feature/menu/widget/text_arrow_form.dart';
import 'package:bladderly/presentation/feature/payment/plan/widget/plan_free_user_widget.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class PlanView extends StatelessWidget {
  const PlanView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlanBloc, PlanState>(
      listener: (context, state) => switch (state) {
        PlanGetPlansSuccess() => PaywallRoute($extra: PaywallRouteExtra(plans: state.plans)).push<void>(context),
        _ => null
      },
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            ModalAppBar(title: 'Plan'.tr(context)),
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ListView(
                    children: [
                      const PlanFreeUserWidget(),
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
                        onTap: () => context.read<PlanBloc>().add(const PlanGetPlans.subscription()),
                      ),
                      TextArrow(
                        title: 'Cancel plan'.tr(context),
                        onTap: () => const PlanCancelRoute().go(context),
                      ),
                      TextArrow(
                        title: 'Enter Promo Code'.tr(context),
                        onTap: () => const PromoCodeRoute().go(context),
                      ),
                      const Gap(130),
                    ],
                  ),
                  Positioned.fill(
                    top: null,
                    bottom: 40,
                    left: 16,
                    right: 16,
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
