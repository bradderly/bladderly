import 'dart:async';
import 'dart:ui';

import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/core/network_checker/network_checker.dart';
import 'package:bladderly/core/recorder/recorder_module.dart';
import 'package:bladderly/domain/exception/domain_exception.dart';
import 'package:bladderly/domain/exception/network_not_connected_exception.dart';
import 'package:bladderly/domain/model/plan.dart';
import 'package:bladderly/presentation/common/bloc/device_bloc.dart';
import 'package:bladderly/presentation/common/bloc/plan_bloc.dart';
import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/widget/common_message_modal.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';
import 'package:bladderly/presentation/router/route/payment_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

abstract class HomeSoundInputWidget extends StatelessWidget {
  factory HomeSoundInputWidget({
    Key? key,
    required bool isActivated,
    required bool showHowToUse,
    required Recorder recorder,
  }) {
    if (!showHowToUse) return _WaitHowToUseHomeSoundInputWidget(key: key);

    if (!isActivated) return _LockedHomeSoundInputWidget(key: key);

    return _UnlockedHomeSoundInputWidget(
      key: key,
      recorder: recorder,
    );
  }

  const HomeSoundInputWidget._({super.key});

  Future<void> _onTap(BuildContext context);

  Widget _buildOverlayWidget(BuildContext context) => const SizedBox.shrink();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTap(context),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 38),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              shadows: context.shadowTheme.shadow1,
            ),
            child: Row(
              children: [
                Text(
                  'Sound Input'.tr(context),
                  style: context.textStyleTheme.b20Bold.copyWith(color: context.colorTheme.neutral.shade10),
                ),
                const Spacer(),
                Assets.icon.icHomeSoundInput.svg(),
              ],
            ),
          ),
          Positioned.fill(child: _buildOverlayWidget(context)),
        ],
      ),
    );
  }
}

class _WaitHowToUseHomeSoundInputWidget extends HomeSoundInputWidget {
  const _WaitHowToUseHomeSoundInputWidget({
    super.key,
  }) : super._();

  @override
  Future<void> _onTap(BuildContext context) async {}

  @override
  Widget _buildOverlayWidget(BuildContext context) => Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Assets.icon.icHomeSoundInputOverlay.svg(fit: BoxFit.cover),
          ),
          Positioned(
            top: 8,
            left: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: context.colorTheme.vermilion.primary.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'lock msg howto'.tr(context).applyWordBreak(),
                      style: context.textStyleTheme.b14SemiBold.copyWith(color: context.colorTheme.neutral.shade0),
                    ),
                  ),
                  RotatedBox(
                    quarterTurns: 1,
                    child: Assets.icon.icCommonArrowBack.svg(
                      width: 16,
                      height: 16,
                      colorFilter: ColorFilter.mode(context.colorTheme.neutral.shade0, BlendMode.srcIn),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
}

class _LockedHomeSoundInputWidget extends HomeSoundInputWidget {
  const _LockedHomeSoundInputWidget({
    super.key,
  }) : super._();

  @override
  Future<void> _onTap(BuildContext context) async {
    final isNetworkConnected = await getIt<NetworkChecker>().isConnected;

    if (!context.mounted) return;

    if (!isNetworkConnected) {
      return CommonMessageModal.showFromDominException<void>(
        context,
        onTap: context.pop,
        exception: const NetworkNotConnectedException(),
      );
    }

    final completer = Completer<List<Plan>>();
    context.read<PlanBloc>().add(PlanGetPlans.subscription(completer: completer));

    return completer.future
        .then(
          (plans) => context.mounted ? PaywallRoute($extra: PaywallRouteExtra(plans: plans)).push<void>(context) : null,
        )
        .onError((error, stackTrace) => null);
  }

  @override
  Widget _buildOverlayWidget(BuildContext context) => Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: ColoredBox(
                color: const Color(0xFFBCBCB7).withValues(alpha: 0.6),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            decoration: BoxDecoration(
              color: context.colorTheme.neutral.shade0.withValues(alpha: 0.72),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Assets.icon.icHomeLock.svg(),
                      const Gap(9),
                      Expanded(
                        child: Text(
                          'lock msg pay'.tr(context).applyWordBreak(),
                          style: context.textStyleTheme.b14SemiBold.copyWith(color: context.colorTheme.neutral.shade10),
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(7),
                Padding(
                  padding: const EdgeInsets.only(left: 49),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: 'lock msg pay link'.tr(context)),
                        const TextSpan(text: ' ->'),
                      ],
                      style: context.textStyleTheme.b14SemiBold
                          .copyWith(color: context.colorTheme.vermilion.primary.shade50),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}

class _UnlockedHomeSoundInputWidget extends HomeSoundInputWidget {
  const _UnlockedHomeSoundInputWidget({
    super.key,
    required Recorder recorder,
  })  : _recorder = recorder,
        super._();

  final Recorder _recorder;

  @override
  Future<void> _onTap(BuildContext context) async {
    final granted = await _recorder.checkPermission();

    if (!context.mounted) return;

    if (!granted) {
      return CommonMessageModal.show<void>(
        context,
        onTap: context.pop,
        title: 'Microphone permission title',
        content: 'Microphone permission body',
      );
    }

    final state = context.read<DeviceBloc>().state;

    if (state case final DeviceCheckSupportSuccess state) {
      if (state.deviceSupportStatus.exception case final DomainException exception) {
        await CommonMessageModal.showFromDominException<void>(
          context,
          onTap: context.pop,
          exception: exception,
        );
      }
    }

    if (!context.mounted) return;

    return const SoundInputRecordingRoute().push<void>(context);
  }
}
