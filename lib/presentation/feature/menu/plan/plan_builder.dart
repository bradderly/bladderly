// Flutter imports:
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/domain/usecase/plan_usecase.dart';
import 'package:bladderly/presentation/feature/menu/plan/bloc/plan_bloc.dart';
import 'package:bladderly/presentation/feature/menu/plan/cubit/plan_form_cubit.dart';
import 'package:bladderly/presentation/feature/menu/plan/plan_modal.dart';

class PlanBuilder extends StatelessWidget {
  const PlanBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PlanFormCubit>(
          create: (_) => PlanFormCubit(),
        ),
        BlocProvider<PlanBloc>(
          create: (_) => PlanBloc(
            planUsecase: getIt<PlanUsecase>(),
          ),
        ),
      ],
      child: const PlanModal(),
    );
  }
}
