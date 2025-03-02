// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/domain/model/history.dart';
import 'package:bladderly/domain/usecase/save_leakage_history_usecase.dart';
import 'package:bladderly/presentation/feature/input/manual_input/leakage/bloc/manual_input_leakage_bloc.dart';
import 'package:bladderly/presentation/feature/input/manual_input/leakage/cubit/manual_input_leakage_form_cubit.dart';
import 'package:bladderly/presentation/feature/input/manual_input/leakage/manual_input_leakage_widget.dart';

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
      child: ManualInputLeakageView(
        recordTime: recordTime,
        isEditing: history != null,
      ),
    );
  }
}
