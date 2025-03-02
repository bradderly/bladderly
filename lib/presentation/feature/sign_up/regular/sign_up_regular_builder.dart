// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/presentation/common/bloc/user_bloc.dart';
import 'package:bladderly/presentation/feature/sign_up/regular/bloc/sign_up_regular_bloc.dart';
import 'package:bladderly/presentation/feature/sign_up/regular/cubit/sign_up_regular_form_cubit.dart';
import 'package:bladderly/presentation/feature/sign_up/regular/sign_up_regular_view.dart';

class SignUpRegularBuilder extends StatelessWidget {
  const SignUpRegularBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignUpRegularFormCubit>(
          create: (_) => SignUpRegularFormCubit(),
        ),
        BlocProvider<SignUpRegularBloc>(
          create: (_) => SignUpRegularBloc(signUpEmailUsecase: getIt()),
        ),
        BlocProvider<UserBloc>.value(
          value: context.read<UserBloc>(),
        ),
      ],
      child: const SignUpRegularView(),
    );
  }
}
