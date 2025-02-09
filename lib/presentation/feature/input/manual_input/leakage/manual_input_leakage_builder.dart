import 'package:bradderly/core/di/di.dart';
import 'package:bradderly/domain/model/history.dart';
import 'package:bradderly/domain/usecase/save_leakage_history_usecase.dart';
import 'package:bradderly/presentation/feature/input/manual_input/leakage/bloc/manual_input_leakage_bloc.dart';
import 'package:bradderly/presentation/feature/input/manual_input/leakage/cubit/manual_input_leakage_form_cubit.dart';
import 'package:bradderly/presentation/feature/input/manual_input/leakage/manual_input_leakage_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManualInputLeakageBuilder extends StatelessWidget {
  const ManualInputLeakageBuilder({
    super.key,
    required this.recordTime,
    this.history,
  });

  final DateTime recordTime;
  final History? history;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ManualInputLeakageFormCubit>(
          create: (_) => ManualInputLeakageFormCubit(
            recordTime: recordTime,
            history: history,
          ),
        ),
        BlocProvider<ManualInputLeakageBloc>(
          create: (_) => ManualInputLeakageBloc(saveLeakageHistoryUsecase: getIt<SaveLeakageHistoryUsecase>()),
        ),
      ],
      child: ManualInputLeakageView(recordTime: recordTime),
    );
  }
}
