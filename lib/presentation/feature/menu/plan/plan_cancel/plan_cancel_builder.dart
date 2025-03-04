// Flutter imports:
import 'package:bladderly/domain/usecase/plan_cancel_usecase.dart';
import 'package:bladderly/presentation/feature/menu/plan/plan_cancel/bloc/plan_cancel_bloc.dart';
import 'package:bladderly/presentation/feature/menu/plan/plan_cancel/plan_cancel_modal.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:bladderly/core/di/di.dart';

class PlanCancelBuilder extends StatelessWidget {
  const PlanCancelBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PlanCancelBloc>(
          create: (_) => PlanCancelBloc(
            planCancelUsecase: getIt<PlanCancelUsecase>(),
          ),
        ),
      ],
      child: const PlanCancelModal(),
    );
  }
}
