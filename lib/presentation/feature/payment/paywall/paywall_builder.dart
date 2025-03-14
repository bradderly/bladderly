// Flutter imports:
import 'package:bladderly/domain/model/membership.dart';
import 'package:bladderly/domain/model/plan.dart';
import 'package:bladderly/domain/model/product.dart';
import 'package:bladderly/presentation/feature/payment/paywall/cubit/paywall_cubit.dart';
import 'package:bladderly/presentation/feature/payment/paywall/model/paywall_plans_model.dart';
import 'package:bladderly/presentation/feature/payment/paywall/paywall_view.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaywallBuilder extends StatelessWidget {
  const PaywallBuilder({
    super.key,
    required this.plans,
  });

  final List<Plan> plans;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PaywallCubit>(
      create: (_) => PaywallCubit(),
      child: PaywallView(
        membership: Membership(
          product: Product.annualSubscription,
          startDate: DateTime.now(),
          endDate: DateTime.now().add(const Duration(days: 365)),
          autoRenewal: true,
        ),

        // context.read<MembershipBloc>().state.membership,
        plans: PaywallPlansModel.fromDomain(plans),
      ),
    );
  }
}
