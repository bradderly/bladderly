import 'package:bradderly/core/di/di.dart';
import 'package:bradderly/core/package_device_info/src/model/device_info_model.dart';
import 'package:bradderly/core/recorder/recorder_module.dart';
import 'package:bradderly/presentation/common/cubit/pending_upload_file_cubit.dart';
import 'package:bradderly/presentation/feature/input/sound_input_recording/sound_input_recording_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SoundInputRecordingBuilder extends StatelessWidget {
  const SoundInputRecordingBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PendingUploadFileCubit>(
      create: (_) => PendingUploadFileCubit(),
      child: SoundInputRecordingView(
        recorder: getIt<Recorder>(),
        deviceInfo: getIt<DeviceInfoModel>(),
        packageInfo: getIt<PackageInfo>(),
      ),
    );
  }
}
