import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/domain/usecase/change_password_usecase.dart';
import 'package:bladderly/presentation/feature/menu/profile/change_password/bloc/change_password_bloc.dart';
import 'package:bladderly/presentation/feature/menu/profile/change_password/change_password_modal.dart';
import 'package:bladderly/presentation/feature/menu/profile/change_password/cubit/change_password_form_cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordBuilder extends StatelessWidget {
  const ChangePasswordBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChangePasswordBloc>(
          create: (_) => ChangePasswordBloc(
            chagnePasswordUsecase: getIt<ChangePasswordUsecase>(),
          ),
        ),
        BlocProvider<ChangePasswordFormCubit>(
          create: (_) => ChangePasswordFormCubit(),
        ),
      ],
      child: const ChangePasswordModal(),
    );
  }
}
