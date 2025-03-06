// Flutter imports:
import 'package:bladderly/domain/exception/not_supported_device_exception.dart';
import 'package:bladderly/presentation/common/bloc/app_config_bloc.dart';
// Project imports:
import 'package:bladderly/presentation/common/bloc/user_bloc.dart';
import 'package:bladderly/presentation/common/widget/common_error_modal.dart';
import 'package:bladderly/presentation/feature/splash/bloc/splash_bloc.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';
import 'package:bladderly/presentation/router/route/intro_route.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    context.read<AppConfigBloc>().add(const AppConfigLoad());

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => Future<void>.delayed(
        const Duration(seconds: 1),
        _checkInialized,
      ),
    );
    super.initState();
  }

  void _checkInialized() {
    if (!mounted) return;

    if (context.read<SplashBloc>().state is! SplashCheckSupportedDeviceSuccess) return;

    landPage();
  }

  Future<void> _onCheckSupportedDeviceFailure(BuildContext context, SplashCheckSupportedDeviceFailure state) {
    if (state.exception case final NotSupportedDeviceException exception) {
      return CommonErrorModal.showFromDominException<void>(
        context,
        onTap: landPage,
        exception: exception,
      );
    }

    return Future<void>.value();
  }

  void landPage() {
    if (context.read<UserBloc>().state is UserLoadSuccess) {
      return const MainRoute().go(context);
    }

    return const IntroRoute().go(context);
  }

  @override
  Widget build(BuildContext context) {
    context.read<AppConfigBloc>().add(const AppConfigLoad());
    return MultiBlocListener(
      listeners: [
        BlocListener<AppConfigBloc, AppConfigState>(
          listener: (context, state) => switch (state) {
            AppConfigLoadSuccess() => context.read<SplashBloc>().add(const SplashCheckSupportedDevice()),
            _ => null
          },
        ),
        BlocListener<SplashBloc, SplashState>(
          listener: (context, state) => switch (state) {
            SplashCheckSupportedDeviceSuccess() => _checkInialized(),
            SplashCheckSupportedDeviceFailure() => _onCheckSupportedDeviceFailure(context, state),
            _ => null,
          },
        ),
      ],
      child: Stack(
        fit: StackFit.expand,
        children: [
          Assets.img.imgOnboardingBg.image(fit: BoxFit.cover),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Center(
                child: Assets.icon.icOnboardingLogo.svg(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
