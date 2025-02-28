import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/presentation/common/bloc/user_bloc.dart';
import 'package:bladderly/presentation/feature/sign_up/guest/bloc/signup_guest_bloc.dart';
import 'package:bladderly/presentation/feature/sign_up/guest/cubit/sign_up_guest_form_cubit.dart';
import 'package:bladderly/presentation/feature/sign_up/guest/sign_up_guest_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpGuestBuilder extends StatelessWidget {
  const SignUpGuestBuilder({
    super.key,
    this.email,
    this.signUpMethod,
  });

  final String? email;
  final String? signUpMethod;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignUpGuestFormCubit>(
          create: (_) => SignUpGuestFormCubit(),
        ),
        BlocProvider<SignUpGuestBloc>(
          create: (_) => SignUpGuestBloc(signupGuestUsecase: getIt()),
        ),
        BlocProvider<UserBloc>.value(
          value: context.read<UserBloc>(),
        ),
      ],
      child: SignUpGuestView(
        email: email,
        signUpMethod: signUpMethod,
      ),
    );
  }
}
