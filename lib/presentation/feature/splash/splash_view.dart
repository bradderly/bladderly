// Flutter imports:
import 'dart:async';

import 'package:bladderly/core/bio_auth/bio_auth.dart';
import 'package:bladderly/core/method_channel/bladdery_method_channel.dart';
import 'package:bladderly/domain/exception/domain_exception.dart';
import 'package:bladderly/presentation/common/bloc/app_config_bloc.dart';
import 'package:bladderly/presentation/common/bloc/device_bloc.dart';
// Project imports:
import 'package:bladderly/presentation/common/bloc/user_bloc.dart';
import 'package:bladderly/presentation/common/cubit/passcode_cubit.dart';
import 'package:bladderly/presentation/common/locale/app_locale.dart';
import 'package:bladderly/presentation/common/widget/common_message_modal.dart';
import 'package:bladderly/presentation/feature/splash/cubit/splash_cubit.dart';
import 'package:bladderly/presentation/feature/splash/modal/splash_soft_update_modal.dart';
import 'package:bladderly/presentation/feature/splash/model/splash_initialization_model.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';
import 'package:bladderly/presentation/router/route/intro_route.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';
import 'package:bladderly/presentation/router/route/passcode_auth_route.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rxdart/rxdart.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SplashView extends StatefulWidget {
  const SplashView({
    super.key,
    required this.methodChannel,
  });

  final BladderyMethodChannel methodChannel;

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final subject = BehaviorSubject<SplashInitializationModel>.seeded(const SplashInitializationModel());

  late final deviceBloc = context.read<DeviceBloc>();

  @override
  void initState() {
    subject.listen((value) => value.isAllInitialized ? onInitialized() : null);

    context.read<AppConfigBloc>().add(const AppConfigLoad());

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => initilize().then(
        (_) => Future<void>.delayed(
          const Duration(seconds: 1),
          () => subject.value = subject.value.copyWith(splashTime: true),
        ),
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    subject.close();
    super.dispose();
  }

  Future<void> initilize() {
    return Future.wait(
      [
        Translation().initialize(),
      ],
    );
  }

  Future<void> onInitialized() async {
    final alreadyLoggedIn = context.read<UserBloc>().state is UserLoadSuccess;
    final isLocked = context.read<PasscodeCubit>().state.isLocked;

    await checkAppVersion(context);

    if (!mounted) return;

    /// 로그인이 되어 있지 않으면 IntroRoute로 이동
    if (!alreadyLoggedIn) return const IntroRoute().go(context);

    if (!isLocked) return const MainRoute().go(context);

    final useBioAtuh = await BioAuth().canAuthenticate();

    if (!mounted) return;

    if (!useBioAtuh) return const PasscodeAuthRoute().go(context);

    // 생채 인증 성공할때 까지 무한 반복
    while (true) {
      final successBioAuth = await BioAuth().authenticate().catchError((_, __) => false);

      if (successBioAuth && mounted) return const MainRoute().go(context);
    }
  }

  Future<void> onAppConfigLoadSuccess(BuildContext context, AppConfigLoadSuccess state) async {
    subject.value = subject.value.copyWith(appConfig: true);

    context.read<DeviceBloc>().add(const DeviceCheckSupport());
    final isLiveListen = await widget.methodChannel.checkLiveListen().onError((_, __) => false);

    if (!context.mounted) return;

    if (!isLiveListen) return Future<void>.sync(() => subject.value = subject.value.copyWith(liveListen: true));

    return CommonMessageModal.show<void>(
      context,
      onTap: () => context.pop(subject.value = subject.value.copyWith(liveListen: true)),
      title: 'Detected: Hearing aid or Live Listen feature',
      content:
          'Please disconnect or turn off your hearing aid or the Live Listen feature, as keeping them on can alter your results.',
    );
  }

  Future<void> checkAppVersion(BuildContext context) async {
    final state = context.read<AppConfigBloc>().state;

    if (state.needForceUpdate) {
      return CommonMessageModal.show<void>(
        context,
        onTap: () => launchUrlString(context.read<AppConfigBloc>().state.storeUrl),
        title: 'Mandatory Update title',
        content: 'Mandatory Update body',
        buttonText: 'Mandatory Update button',
      );
    }
    final alreadyChecked = context.read<SplashCubit>().state.isAlreadyChecked(state.currentVersion);

    if (state.needSoftUpdate && !alreadyChecked) {
      return SplashSoftUpdateModal.show(
        context,
        onTapUpdate: () => launchUrlString(state.storeUrl),
        onTapLater: () => context
          ..read<SplashCubit>().onCheckVersion(state.currentVersion)
          ..pop(),
      );
    }
  }

  Future<void> onCheckSupportedDeviceSuccess(BuildContext context, DeviceCheckSupportSuccess state) {
    return switch (state.deviceSupportStatus.exception) {
      final DomainException exception => CommonMessageModal.showFromDominException<void>(
          context,
          onTap: onInitialized,
          exception: exception,
        ),
      _ => Future<void>.sync(() => subject.value = subject.value.copyWith(device: true)),
    };
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AppConfigBloc, AppConfigState>(
          listener: (context, state) => switch (state) {
            AppConfigLoadSuccess() => onAppConfigLoadSuccess(context, state),
            AppConfigLoadFailure() => subject.value = subject.value.copyWith(appConfig: true),
            _ => null,
          },
        ),
        BlocListener<DeviceBloc, DeviceState>(
          listener: (context, state) => switch (state) {
            DeviceCheckSupportSuccess() => onCheckSupportedDeviceSuccess(context, state),
            DeviceCheckSupportFailure() => subject.value = subject.value.copyWith(device: true),
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
