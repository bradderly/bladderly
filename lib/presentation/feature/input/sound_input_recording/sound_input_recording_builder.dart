// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/core/recorder/recorder_module.dart';
import 'package:bladderly/presentation/common/cubit/pending_upload_file_cubit.dart';
import 'package:bladderly/presentation/feature/input/sound_input_recording/sound_input_recording_view.dart';

class SoundInputRecordingBuilder extends StatelessWidget {
  const SoundInputRecordingBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PendingUploadFileCubit>(
      create: (_) => PendingUploadFileCubit(),
      child: SoundInputRecordingView(
        recorder: getIt<Recorder>(),
      ),
    );
  }
}
