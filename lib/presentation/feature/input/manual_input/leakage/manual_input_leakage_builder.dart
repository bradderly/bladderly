import 'package:bradderly/domain/model/history.dart';
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
  final LeakageHistory? history;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ManualInputLeakageFormCubit>(
      create: (_) => ManualInputLeakageFormCubit(
        recordTime: recordTime,
        history: history,
      ),
      child: ManualInputLeakageView(recordTime: recordTime),
    );
  }
}
