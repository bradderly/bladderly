import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/domain/usecase/reset_password_usecasey.dart';
import 'package:bladderly/domain/usecase/send_verification_code_usecase.dart';
import 'package:bladderly/presentation/feature/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:bladderly/presentation/feature/forgot_password/cubit/forgot_password_form_cubit.dart';
import 'package:bladderly/presentation/feature/forgot_password/forgot_password_view.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordBuilder extends StatelessWidget {
  const ForgotPasswordBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ForgotPasswordBloc>(
          create: (context) => ForgotPasswordBloc(
            sendVerificationCodeUsecase: getIt<SendVerificationCodeUsecase>(),
            resetPasswordUsecase: getIt<ResetPasswordUsecase>(),
          ),
        ),
        BlocProvider<ForgotPasswordFormCubit>(
          create: (context) => ForgotPasswordFormCubit(),
        ),
      ],
      child: const ForgotPasswordView(),
    );
  }
}
