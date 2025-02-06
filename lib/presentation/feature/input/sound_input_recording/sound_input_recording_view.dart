import 'dart:async';

import 'package:bradderly/core/package_device_info/src/model/device_info_model.dart';
import 'package:bradderly/core/recorder/recorder_module.dart';
import 'package:bradderly/core/recorder/src/recorder_file.dart';
import 'package:bradderly/presentation/common/bloc/user_bloc.dart';
import 'package:bradderly/presentation/common/cubit/pending_upload_file_cubit.dart';
import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/extension/string_extension.dart';
import 'package:bradderly/presentation/feature/input/sound_input_recording/widget/sound_input_recording_stop_dialog.dart';
import 'package:bradderly/presentation/generated/assets/assets.gen.dart';
import 'package:bradderly/presentation/router/route/main_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:synchronized/synchronized.dart';

class SoundInputRecordingView extends StatefulWidget {
  const SoundInputRecordingView({
    super.key,
    required this.recorder,
    required this.deviceInfo,
    required this.packageInfo,
  });

  final Recorder recorder;
  final DeviceInfoModel deviceInfo;
  final PackageInfo packageInfo;

  @override
  State<SoundInputRecordingView> createState() => _SoundInputRecordingViewState();
}

class _SoundInputRecordingViewState extends State<SoundInputRecordingView> with WidgetsBindingObserver {
  late final recordTime = DateTime.now();
  final lock = Lock();

  Duration remainingDuration = const Duration(seconds: 3);

  @override
  void initState() {
    WidgetsBinding.instance
      ..addObserver(this)
      ..addPostFrameCallback((_) => startRecordingCountDown());

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      cancelRecording().then((_) => mounted ? Navigator.of(context).pop<void>() : null);
    }
  }

  Future<void> startRecording() async {
    final userModel = context.read<UserBloc>().state.userModel;

    final fileName = [
      userModel.id,
      DateFormat('yyyyMMdd-HHmmss').format(recordTime),
      widget.deviceInfo.name,
      widget.packageInfo.version,
      userModel.gender,
      'diary-null.m4a',
    ].join('-');

    await lock.synchronized(() => widget.recorder.start(fileName: fileName));

    await Future<void>.delayed(const Duration(seconds: 3));

    if (widget.recorder.state is RecorderRecording && mounted) return completeRecording();
  }

  Future<void> completeRecording() async {
    if (lock.locked) return;

    final file = await lock.synchronized(widget.recorder.stop);

    if (!mounted || !widget.recorder.exist(file)) return;

    context.read<PendingUploadFileCubit>().setFileName(file);

    final $extra = SoundInputNoteRouteExtra(file: file);

    return SoundInputNoteRoute($extra: $extra).pushReplacement(context);
  }

  Future<void> cancelRecording() async {
    if (lock.locked) return;

    final file = await lock.synchronized<RecorderFile?>(() => widget.recorder.stop()).catchError((_) => null);

    if (file case final RecorderFile file) {
      widget.recorder.delete(file);
    }
  }

  void startRecordingCountDown() {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (!mounted) return timer.cancel();

        if (remainingDuration.inSeconds == 0) {
          startRecording();
          return timer.cancel();
        }

        setState(() => remainingDuration -= const Duration(seconds: 1));
      },
    );
  }

  Future<void> showRecordingCancelDialog() async {
    final shouldCancelRecord = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => SoundInputRecordingCancelDialog(
        onCancel: () {
          cancelRecording();
          Navigator.of(context).pop<bool>(true);
        },
        onContinue: () => Navigator.of(context).pop<void>(),
      ),
    );

    if (shouldCancelRecord == true && mounted) Navigator.of(context).pop();
  }

  void onPop() {
    if (widget.recorder.state is RecorderRecording) {
      showRecordingCancelDialog();
    } else {
      Navigator.of(context).pop<void>();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          onPop();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: context.colorTheme.paleLime.shade20,
          body: SafeArea(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  top: 128,
                  left: 16,
                  right: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StreamBuilder<RecorderState>(
                        initialData: widget.recorder.state,
                        stream: widget.recorder.onStateChanged(),
                        builder: (context, snapshot) => Text(
                          switch (snapshot.data) {
                            RecorderIdle() => 'Preparing for the recording'.tr(context),
                            RecorderRecording() => 'Recording started!'.tr(context),
                            _ => '',
                          },
                          style: context.textStyleTheme.b24Bold.copyWith(
                            color: context.colorTheme.neutral.shade10,
                          ),
                        ),
                      ),
                      const Gap(41),
                      // LayoutBuilder(
                      //   builder: (context, constraints) => SizedBox(
                      //     width: constraints.maxWidth,
                      //     height: constraints.maxWidth,
                      //     child: Stack(
                      //       children: [
                      //         const RippleEffect(),
                      //         Container(
                      //           width: constraints.maxWidth,
                      //           height: constraints.maxWidth,
                      //           alignment: Alignment.center,
                      //           child: Text(
                      //             '${remainingDuration.inSeconds}',
                      //             style: context.textStyleTheme.b20Bold.copyWith(
                      //               color: context.colorTheme.neutral.shade0,
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                StreamBuilder<RecorderState>(
                  initialData: widget.recorder.state,
                  stream: widget.recorder.onStateChanged(),
                  builder: (context, snapshot) {
                    if (snapshot.data is! RecorderRecording) return const SizedBox.shrink();

                    return Positioned.fill(
                      top: null,
                      bottom: 44,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Tap to stop recording'.tr(context),
                            style: context.textStyleTheme.b16SemiBold
                                .copyWith(color: context.colorTheme.vermilion.primary.shade50),
                          ),
                          const Gap(16),
                          GestureDetector(
                            onTap: completeRecording,
                            child: Container(
                              width: 78,
                              height: 78,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: context.colorTheme.neutral.shade0,
                                shape: BoxShape.circle,
                              ),
                              child: Container(
                                width: 65,
                                height: 65,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: context.colorTheme.vermilion.primary.shade50,
                                  shape: BoxShape.circle,
                                ),
                                child: Container(
                                  width: 26,
                                  height: 26,
                                  color: context.colorTheme.neutral.shade0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Positioned(
                  top: 18,
                  right: 16,
                  child: GestureDetector(
                    onTap: onPop,
                    child: Assets.icon.icExportClose.svg(
                      colorFilter: ColorFilter.mode(
                        context.colorTheme.neutral.shade8,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
