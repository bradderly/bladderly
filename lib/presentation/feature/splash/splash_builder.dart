// Flutter imports:
import 'package:bladderly/presentation/feature/splash/cubit/splash_cubit.dart';
import 'package:bladderly/presentation/feature/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashBuilder extends StatelessWidget {
  const SplashBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashCubit>(
      create: (_) => SplashCubit(),
      child: const SplashView(),
    );
  }
}
