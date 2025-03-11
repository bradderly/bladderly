// Dart imports:
import 'dart:async';

// Project imports:
import 'package:bladderly/core/recorder/recorder_module.dart';
import 'package:bladderly/presentation/common/cubit/pending_upload_file_cubit.dart';
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/feature/input/sound_input_recording/widget/sound_input_recording_stop_dialog.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:synchronized/synchronized.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class SoundInputRecordingView extends StatefulWidget {
  const SoundInputRecordingView({
    super.key,
    required this.recorder,
  });

  final Recorder recorder;

  @override
  State<SoundInputRecordingView> createState() => _SoundInputRecordingViewState();
}

class _SoundInputRecordingViewState extends State<SoundInputRecordingView> with WidgetsBindingObserver {
  late final recordTime = DateTime.now();
  final lock = Lock();
  final now = DateTime.now();

  Duration remainingDuration = const Duration(seconds: 3);

  @override
  void initState() {
    Future<void>.delayed(
      const Duration(minutes: 3),
      () => widget.recorder.state is RecorderRecording && mounted ? completeRecording() : null,
    );

    WakelockPlus.enable();
    WidgetsBinding.instance
      ..addObserver(this)
      ..addPostFrameCallback((_) => startRecordingCountDown());

    super.initState();
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      cancelRecording().then((_) => mounted ? Navigator.of(context).pop<void>() : null);
    }
  }

  Future<void> completeRecording() async {
    return lock.synchronized(() async {
      final recordTime = await widget.recorder.stop();

      if (!mounted || !widget.recorder.getFile(recordTime).existsSync()) return;

      context.read<PendingUploadFileCubit>().setRecordTime(recordTime);

      return SoundInputNoteRoute(recordTime: recordTime).pushReplacement(context);
    });
  }

  Future<void> cancelRecording() {
    return lock.synchronized(
      () => widget.recorder
          .stop()
          .then<void>((recordTime) => widget.recorder.getFile(recordTime).deleteSync())
          .catchError((_) => null),
    );
  }

  void startRecordingCountDown() {
    Timer.periodic(
      const Duration(milliseconds: 10),
      (timer) {
        if (!mounted) return timer.cancel();

        if (remainingDuration > Duration.zero) {
          setState(() => remainingDuration -= const Duration(milliseconds: 10));
        }

        if (remainingDuration == Duration.zero) {
          widget.recorder.start(recordTime: recordTime);
          return timer.cancel();
        }
      },
    );
  }

  Future<void> showRecordingCancelDialog() async {
    final shouldCancelRecord = await SoundInputRecordingCancelDialog.show(
      context,
      onCancel: () {
        cancelRecording();
        Navigator.of(context).pop<bool>(true);
      },
      onContinue: () => Navigator.of(context).pop<void>(),
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
                      Stack(
                        children: [
                          Assets.lottie.lottieInputRippleWave.lottie(
                            width: MediaQuery.of(context).size.width - 32,
                            height: MediaQuery.of(context).size.width - 32,
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width - 32,
                            height: MediaQuery.of(context).size.width - 32,
                            child: StreamBuilder<RecorderState>(
                              initialData: widget.recorder.state,
                              stream: widget.recorder.onStateChanged(),
                              builder: (context, snapshot) => Stack(
                                children: [
                                  Center(
                                    child: Text(
                                      snapshot.data is RecorderIdle
                                          ? '${remainingDuration.inSeconds}'
                                          : 'Recording...'.tr(context),
                                      style: context.textStyleTheme.b20Bold.copyWith(
                                        color: snapshot.data is RecorderIdle
                                            ? context.colorTheme.neutral.shade0
                                            : const Color(0xFF87A218),
                                      ),
                                    ),
                                  ),
                                  if (snapshot.data is RecorderIdle)
                                    Center(
                                      child: SizedBox(
                                        width: 45,
                                        height: 45,
                                        child: CircularProgressIndicator(
                                          color: context.colorTheme.paleLime.shade20,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(context.colorTheme.paleLime.shade60),
                                          value: 1 - remainingDuration.inMilliseconds / 3000,
                                          strokeCap: StrokeCap.round,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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
