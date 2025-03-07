// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/domain/model/history.dart';
import 'package:bladderly/domain/usecase/save_voiding_history_usecase.dart';
import 'package:bladderly/presentation/common/cubit/unit_cubit.dart';
import 'package:bladderly/presentation/feature/input/manual_input/voiding/bloc/manual_input_voiding_bloc.dart';
import 'package:bladderly/presentation/feature/input/manual_input/voiding/cubit/manual_input_voiding_form_cubit.dart';
import 'package:bladderly/presentation/feature/input/manual_input/voiding/manual_input_voiding_widget.dart';

class ManualInputVoidingBuilder extends StatelessWidget {
  const ManualInputVoidingBuilder({
    super.key,
    required this.recordTime,
    required this.history,
  });

  final DateTime recordTime;
  final History? history;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ManualInputVoidingFormCubit>(
          create: (context) => ManualInputVoidingFormCubit(
            unit: context.read<UnitCubit>().state,
            recordTime: recordTime,
            history: history,
          ),
        ),
        BlocProvider<ManualInputVoidingBloc>(
          create: (_) => ManualInputVoidingBloc(saveVoidingHistoryUsecase: getIt<SaveVoidingHistoryUsecase>()),
        ),
      ],
      child: ManualInputVoidingWidget(
        recordTime: recordTime,
        isEditing: history != null,
      ),
    );
  }
}
