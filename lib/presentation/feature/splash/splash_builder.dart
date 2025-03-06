// Flutter imports:
import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/domain/usecase/check_supported_device_usecase.dart';
import 'package:bladderly/presentation/feature/splash/bloc/splash_bloc.dart';
import 'package:bladderly/presentation/feature/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashBuilder extends StatelessWidget {
  const SplashBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashBloc>(
      create: (_) => SplashBloc(
        checkSupportedDeviceUsecase: getIt<CheckSupportedDeviceUsecase>(),
      ),
      child: const SplashView(),
    );
  }
}
