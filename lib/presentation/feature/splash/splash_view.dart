// Flutter imports:
import 'dart:async';

import 'package:bladderly/core/bio_auth/bio_auth.dart';
import 'package:bladderly/core/bluetooth_hfp/bluetooth_hfp_check.dart';
import 'package:bladderly/domain/exception/bluetooth_hfp_exception.dart';
import 'package:bladderly/domain/exception/not_supported_device_exception.dart';
import 'package:bladderly/domain/exception/update_new_version_exception.dart';
import 'package:bladderly/domain/exception/update_new_version_must_exception.dart';
import 'package:bladderly/presentation/common/bloc/app_config_bloc.dart';
// Project imports:
import 'package:bladderly/presentation/common/bloc/user_bloc.dart';
import 'package:bladderly/presentation/common/cubit/passcode_cubit.dart';
import 'package:bladderly/presentation/common/widget/common_error_modal.dart';
import 'package:bladderly/presentation/common/widget/common_update_modal.dart';
import 'package:bladderly/presentation/feature/splash/bloc/splash_bloc.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';
import 'package:bladderly/presentation/router/route/intro_route.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';
import 'package:bladderly/presentation/router/route/passcode_auth_route.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rxdart/rxdart.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final subject =
      BehaviorSubject<({bool waitingSuccess, bool initialized})>.seeded((waitingSuccess: false, initialized: false));

  @override
  void initState() {
    subject.map((value) => value.initialized && value.waitingSuccess).listen((value) => value ? landPage() : null);

    context.read<AppConfigBloc>().add(const AppConfigLoad());

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => Future<void>.delayed(
        const Duration(seconds: 1),
        () => subject.value = (waitingSuccess: true, initialized: subject.value.initialized),
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    subject.close();
    super.dispose();
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

  Future<void> landPage() async {
    final alreadyLoggedIn = context.read<UserBloc>().state is UserLoadSuccess;
    final isLocked = context.read<PasscodeCubit>().state.isLocked;

    await checkAppVersion(); //  앱 버전 체크가 끝날 때까지 대기

    await checkBluetoothHFP(); //  블루투스 체크가 끝날 때까지 대기

    /// 로그인이 되어 있지 않으면 IntroRoute로 이동
    if (!alreadyLoggedIn) return const IntroRoute().go(context);

    if (!isLocked) return const MainRoute().go(context);

    final useBioAtuh = await BioAuth().canAuthenticate();

    if (!mounted) return;

    if (!useBioAtuh) {
      return const PasscodeAuthRoute().go(context);
    }

    while (true) {
      final successBioAuth = await BioAuth().authenticate();

      if (successBioAuth && mounted) return const MainRoute().go(context);
    }
  }

  Future<void> checkAppVersion() async {
    final appConfigState = context.read<AppConfigBloc>().state.appVersion;

    // 강제 업데이트
    if (compareVersions(appConfigState.currentVersion, appConfigState.minVersion) < 0) {
      print('강제 업데이트가 필요합니다.');
      await CommonUpdateModal.showFromDominException<void>(
        context,
        onTap: context.pop,
        exception: const UpdateNewVersionMustException(),
      );
    } else if (compareVersions(appConfigState.currentVersion, appConfigState.latestVersion) < 0) {
      print('새로운 업데이트가 있습니다.');
      await CommonUpdateModal.showFromDominException<void>(
        context,
        onTap: context.pop,
        exception: const UpdateNewVersionException(),
      );
    }
  }

  int compareVersions(String version1, String version2) {
    final v1 = version1.split('.').map(int.parse).toList();
    final v2 = version2.split('.').map(int.parse).toList();

    for (var i = 0; i < v1.length; i++) {
      if (v1[i] < v2[i]) return -1;
      if (v1[i] > v2[i]) return 1;
    }
    return 0;
  }

  Future<void> checkBluetoothHFP() async {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      final isConnected = await BluetoothHFPChecker.isBluetoothHFPConnected();

      if (isConnected) {
        await CommonErrorModal.showFromDominException<void>(
          context,
          onTap: context.pop,
          exception: const BluetoothHfpException(),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
            SplashCheckSupportedDeviceSuccess() => subject.value =
                (waitingSuccess: subject.value.waitingSuccess, initialized: true),
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
