import 'package:bladderly/core/recorder/recorder_module.dart';
import 'package:bladderly/domain/exception/domain_exception.dart';
import 'package:bladderly/presentation/common/bloc/device_bloc.dart';
import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/widget/common_error_modal.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                  Text(
                    'Learn to use this function before starting'.tr(context),
                    style: context.textStyleTheme.b14SemiBold.copyWith(color: context.colorTheme.neutral.shade0),
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
    // TODO: implement _onTap
  }
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
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Microphone permission title'.tr(context)),
          content: Text('Microphone permission body'.tr(context)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Okay'.tr(context)),
            ),
          ],
        ),
      );
    }

    final state = context.read<DeviceBloc>().state;

    if (state is! DeviceCheckSupportSuccess) return;

    if (state.deviceSupportStatus.exception case final DomainException exception) {
      await CommonErrorModal.showFromDominException<void>(
        context,
        onTap: context.pop,
        exception: exception,
      );
    }

    if (!context.mounted) return;

    return const SoundInputRecordingRoute().push<void>(context);
  }
}
