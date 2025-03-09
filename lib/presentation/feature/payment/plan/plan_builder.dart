// Flutter imports:
import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/domain/usecase/get_paywall_plans_usecase.dart';
import 'package:bladderly/presentation/feature/payment/plan/bloc/plan_bloc.dart';
import 'package:bladderly/presentation/feature/payment/plan/plan_modal.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanBuilder extends StatelessWidget {
  const PlanBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PlanBloc>(
      create: (context) => PlanBloc(
        getPaywallPlansUsecase: getIt<GetPaywallPlansUsecase>(),
      ),
      child: const PlanModal(),
    );
  }
}
