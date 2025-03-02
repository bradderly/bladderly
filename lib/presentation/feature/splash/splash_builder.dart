// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:bladderly/presentation/common/bloc/user_bloc.dart';
import 'package:bladderly/presentation/feature/splash/splash_view.dart';

class SplashBuilder extends StatelessWidget {
  const SplashBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>.value(
      value: context.read<UserBloc>(),
      child: const SplashView(),
    );
  }
}
