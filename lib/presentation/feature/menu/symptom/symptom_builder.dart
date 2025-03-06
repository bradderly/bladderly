// Flutter imports:
import 'package:bladderly/domain/usecase/symptom_history_usecase.dart';
import 'package:bladderly/presentation/feature/menu/symptom/bloc/symptom_history_bloc.dart';
import 'package:bladderly/presentation/feature/menu/symptom/cubit/symptom_history_form_cubit.dart';
import 'package:bladderly/presentation/feature/menu/symptom/symptom_modal.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/domain/usecase/get_user_stream_usecase.dart';
import 'package:bladderly/domain/usecase/get_user_usecase.dart';
import 'package:bladderly/domain/usecase/sign_out_usecase.dart';
import 'package:bladderly/presentation/common/bloc/user_bloc.dart';

class SymptomBuilder extends StatelessWidget {
  const SymptomBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SymptomHistoryFormCubit>(
          create: (_) => SymptomHistoryFormCubit(),
        ),
        BlocProvider<SymptomHistoryBloc>(
          create: (_) => SymptomHistoryBloc(
            symtomHistoryUsecase: getIt<SymptomHistoryUsecase>(),
          ),
        ),
      ],
      child: const SymptomModal(),
    );
  }
}
