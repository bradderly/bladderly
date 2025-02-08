import 'package:bradderly/core/di/di.dart';
import 'package:bradderly/domain/model/history.dart';
import 'package:bradderly/domain/usecase/save_intake_history_usecase.dart';
import 'package:bradderly/presentation/common/cubit/unit_cubit.dart';
import 'package:bradderly/presentation/common/model/beverage_type_model.dart';
import 'package:bradderly/presentation/feature/input/intake_input/bloc/intake_input_bloc.dart';
import 'package:bradderly/presentation/feature/input/intake_input/cubit/intake_input_form_cubit.dart';
import 'package:bradderly/presentation/feature/input/intake_input/intake_input_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IntakeInputBuilder extends StatelessWidget {
  const IntakeInputBuilder({
    super.key,
    required this.beverageTypeModel,
    required this.intakeHistory,
  });

  final BeverageTypeModel? beverageTypeModel;
  final IntakeHistory? intakeHistory;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<IntakeInputFormCubit>(
          create: (_) => IntakeInputFormCubit(
            unit: context.read<UnitCubit>().state,
            recordTime: DateTime.now(),
            beverageTypeModel: beverageTypeModel,
            intakeHistory: intakeHistory,
          ),
        ),
        BlocProvider<IntakeInputBloc>(
          create: (_) => IntakeInputBloc(saveIntakeHistoryUsecase: getIt<SaveIntakeHistoryUsecase>()),
        ),
      ],
      child: const IntakeInputView(),
    );
  }
}
