// Flutter imports:
// Project imports:
import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/domain/model/history.dart';
import 'package:bladderly/domain/usecase/get_history_usecase.dart';
import 'package:bladderly/domain/usecase/save_intake_history_usecase.dart';
import 'package:bladderly/presentation/common/cubit/unit_cubit.dart';
import 'package:bladderly/presentation/common/model/beverage_type_model.dart';
import 'package:bladderly/presentation/feature/input/intake_input/bloc/intake_input_bloc.dart';
import 'package:bladderly/presentation/feature/input/intake_input/cubit/intake_input_form_cubit.dart';
import 'package:bladderly/presentation/feature/input/intake_input/intake_input_view.dart';
import 'package:flutter/cupertino.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

class IntakeInputBuilder extends StatefulWidget {
  const IntakeInputBuilder({
    super.key,
    required this.beverageTypeModel,
    required this.recordTime,
  });

  final BeverageTypeModel? beverageTypeModel;
  final DateTime? recordTime;

  @override
  State<IntakeInputBuilder> createState() => _IntakeInputBuilderState();
}

class _IntakeInputBuilderState extends State<IntakeInputBuilder> {
  late final intakeHistory = switch (widget.recordTime) {
    final DateTime recordTime =>
      getIt<GetHistoryUsecase>().call(recordTime: recordTime).fold((l) => null, (r) => r is IntakeHistory ? r : null),
    _ => null,
  };

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<IntakeInputFormCubit>(
          create: (_) => IntakeInputFormCubit(
            unit: context.read<UnitCubit>().state,
            recordTime: DateTime.now(),
            beverageTypeModel: widget.beverageTypeModel,
            intakeHistory: intakeHistory,
          ),
        ),
        BlocProvider<IntakeInputBloc>(
          create: (_) => IntakeInputBloc(saveIntakeHistoryUsecase: getIt<SaveIntakeHistoryUsecase>()),
        ),
      ],
      child: IntakeInputView(isEditing: widget.recordTime != null),
    );
  }
}
