import 'package:bradderly/core/di/di.dart';
import 'package:bradderly/presentation/feature/signup/guest/bloc/signup_guest_bloc.dart';
import 'package:bradderly/presentation/feature/signup/guest/cubit/signup_guest_form_cubit.dart';
import 'package:bradderly/presentation/feature/signup/guest/signup_guest_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupGuestBuilder extends StatelessWidget {
  const SignupGuestBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignupGuestFormCubit>(
          create: (_) => SignupGuestFormCubit(),
        ),
        BlocProvider(
          create: (_) => SignupGuestBloc(signupGuestUsecase: getIt()),
        ),
      ],
      child: const SignupGuestView(),
    );
  }
}
