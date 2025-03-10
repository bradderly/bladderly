// Flutter imports:
import 'package:bladderly/domain/model/plan.dart';
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
        plans: PaywallPlansModel.fromDomain(plans),
      ),
    );
  }
}
