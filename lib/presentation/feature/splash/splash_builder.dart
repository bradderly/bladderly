import 'package:bradderly/presentation/common/bloc/user_bloc.dart';
import 'package:bradderly/presentation/feature/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
