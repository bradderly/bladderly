// Flutter imports:
import 'dart:async';

import 'package:bladderly/core/bio_auth/bio_auth.dart';
import 'package:bladderly/domain/exception/domain_exception.dart';
import 'package:bladderly/presentation/common/bloc/app_config_bloc.dart';
import 'package:bladderly/presentation/common/bloc/device_bloc.dart';
// Project imports:
import 'package:bladderly/presentation/common/bloc/user_bloc.dart';
import 'package:bladderly/presentation/common/cubit/passcode_cubit.dart';
import 'package:bladderly/presentation/common/locale/app_locale.dart';
import 'package:bladderly/presentation/common/widget/common_error_modal.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';
import 'package:bladderly/presentation/router/route/intro_route.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';
import 'package:bladderly/presentation/router/route/passcode_auth_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final subject =
      BehaviorSubject<({bool waitingSuccess, bool initialized})>.seeded((waitingSuccess: false, initialized: false));

  late final deviceBloc = context.read<DeviceBloc>();

  @override
  void initState() {
    subject.map((value) => value.initialized && value.waitingSuccess).listen((value) => value ? landPage() : null);

    context.read<AppConfigBloc>().add(const AppConfigLoad());

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => Future.wait([Firebase.initializeApp(), Translation().initialize()]).then(
        (_) => Future<void>.delayed(const Duration(seconds: 1), () => setSubjectValue(waitingSuccess: true)),
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    subject.close();
    super.dispose();
  }

  void setSubjectValue({bool? waitingSuccess, bool? initialized}) {
    subject.value = (
      waitingSuccess: waitingSuccess ?? subject.value.waitingSuccess,
      initialized: initialized ?? subject.value.initialized
    );
  }

  Future<void> landPage() async {
    final alreadyLoggedIn = context.read<UserBloc>().state is UserLoadSuccess;
    final isLocked = context.read<PasscodeCubit>().state.isLocked;

    /// 로그인이 되어 있지 않으면 IntroRoute로 이동
    if (!alreadyLoggedIn) return const IntroRoute().go(context);

    if (!isLocked) return const MainRoute().go(context);

    final useBioAtuh = await BioAuth().canAuthenticate();

    if (!mounted) return;

    if (!useBioAtuh) return const PasscodeAuthRoute().go(context);

    // 생채 인증 성공할때 까지 무한 반복
    while (true) {
      final successBioAuth = await BioAuth().authenticate();

      if (successBioAuth && mounted) return const MainRoute().go(context);
    }
  }

  void onAppConfigLoadSuccess(BuildContext context, AppConfigLoadSuccess state) {
    if (deviceBloc.state is DeviceCheckSupportSuccess) {
      return setSubjectValue(initialized: true);
    }

    return context.read<DeviceBloc>().add(const DeviceCheckSupport());
  }

  Future<void> onCheckSupportedDeviceSuccess(BuildContext context, DeviceCheckSupportSuccess state) {
    return switch (state.deviceSupportStatus.exception) {
      final DomainException exception => CommonErrorModal.showFromDominException<void>(
          context,
          onTap: landPage,
          exception: exception,
        ),
      _ => Future<void>.sync(() => setSubjectValue(initialized: true)),
    };
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AppConfigBloc, AppConfigState>(
          listener: (context, state) => switch (state) {
            AppConfigLoadSuccess() => onAppConfigLoadSuccess(context, state),
            AppConfigLoadFailure() => setSubjectValue(initialized: true),
            _ => null,
          },
        ),
        BlocListener<DeviceBloc, DeviceState>(
          listener: (context, state) => switch (state) {
            DeviceCheckSupportSuccess() => onCheckSupportedDeviceSuccess(context, state),
            DeviceCheckSupportFailure() => setSubjectValue(initialized: true),
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
