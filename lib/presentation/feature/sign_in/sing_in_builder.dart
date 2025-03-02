// Flutter imports:
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/domain/usecase/sign_in_social_usecase.dart';
import 'package:bladderly/domain/usecase/sign_in_usecase.dart';
import 'package:bladderly/presentation/feature/sign_in/bloc/signin_bloc.dart';
import 'package:bladderly/presentation/feature/sign_in/cubit/sign_in_form_cubit.dart';
import 'package:bladderly/presentation/feature/sign_in/sign_in_view.dart';

class SinginBuilder extends StatelessWidget {
  const SinginBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SignInFormCubit(),
        ),
        BlocProvider<SignInBloc>(
          create: (_) => SignInBloc(
            signinUsecase: getIt<SignInUsecase>(),
            signinSocialUsecase: getIt<SignInSocialUsecase>(),
          ),
        ),
      ],
      child: const SignInView(),
    );
  }
}
