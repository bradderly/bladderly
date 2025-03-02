// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/presentation/common/bloc/user_bloc.dart';
import 'package:bladderly/presentation/feature/sign_up/guest/bloc/signup_guest_bloc.dart';
import 'package:bladderly/presentation/feature/sign_up/guest/sign_up_guest_view.dart';

class SignUpGuestBuilder extends StatelessWidget {
  const SignUpGuestBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignUpGuestBloc>(
          create: (_) => SignUpGuestBloc(signupGuestUsecase: getIt()),
        ),
        BlocProvider<UserBloc>.value(
          value: context.read<UserBloc>(),
        ),
      ],
      child: const SignUpGuestView(),
    );
  }
}
