// Flutter imports:
import 'package:bladderly/presentation/feature/menu/plan/cubit/plan_form_cubit.dart';
import 'package:bladderly/presentation/feature/menu/plan/plan_modal.dart';
import 'package:flutter/widgets.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanBuilder extends StatelessWidget {
  const PlanBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PlanFormCubit>(
          create: (_) => PlanFormCubit(),
        ),
      ],
      child: const PlanModal(),
    );
  }
}
