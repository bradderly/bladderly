import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/domain/usecase/check_already_exist_user_usecase.dart';
import 'package:bladderly/domain/usecase/sign_in_social_usecase.dart';
import 'package:bladderly/presentation/feature/sign_up/method/bloc/sign_up_method_bloc.dart';
import 'package:bladderly/presentation/feature/sign_up/method/cubit/sign_up_method_form_cubit.dart';
import 'package:bladderly/presentation/feature/sign_up/method/sign_up_method_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpMethodBuilder extends StatelessWidget {
  const SignUpMethodBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignUpMethodBloc>(
          create: (_) => SignUpMethodBloc(
            signInSocialUsecase: getIt<SignInSocialUsecase>(),
            checkAlreadyExistUserUsecase: getIt<CheckAlreadyExistUserUsecase>(),
          ),
        ),
        BlocProvider<SignUpMethodFormCubit>(
          create: (context) => SignUpMethodFormCubit(),
        ),
      ],
      child: const SignUpMethodView(),
    );
  }
}
