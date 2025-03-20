// Flutter imports:
import 'package:bladderly/domain/model/plan.dart';
import 'package:bladderly/presentation/common/bloc/membership_bloc.dart';
import 'package:bladderly/presentation/feature/payment/paywall/cubit/paywall_cubit.dart';
import 'package:bladderly/presentation/feature/payment/paywall/model/paywall_plans_model.dart';
import 'package:bladderly/presentation/feature/payment/paywall/paywall_view.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaywallBuilder extends StatelessWidget {
  const PaywallBuilder({
    super.key,
    required this.plans,
    this.offerToken,
  });

  final List<Plan> plans;
  final String? offerToken;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PaywallCubit>(
      create: (_) => PaywallCubit(),
      child: PaywallView(
        subscription: context.read<MembershipBloc>().state.membership?.subscription,
        plans: PaywallPlansModel.fromDomain(plans),
        offerToken: offerToken,
      ),
    );
  }
}
