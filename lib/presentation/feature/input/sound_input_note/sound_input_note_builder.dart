import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/core/recorder/recorder_module.dart';
import 'package:bladderly/core/recorder/src/recorder_file.dart';
import 'package:bladderly/domain/usecase/save_voiding_history_with_file_usecase.dart';
import 'package:bladderly/presentation/common/cubit/pending_upload_file_cubit.dart';
import 'package:bladderly/presentation/feature/input/sound_input_note/bloc/sound_input_note_bloc.dart';
import 'package:bladderly/presentation/feature/input/sound_input_note/cubit/sound_input_note_form_cubit.dart';
import 'package:bladderly/presentation/feature/input/sound_input_note/sound_input_note_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SoundInputNoteBuilder extends StatelessWidget {
  const SoundInputNoteBuilder({
    super.key,
    required this.recorderFile,
  });

  final RecorderFile recorderFile;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SoundInputNoteFormCubit>(
          create: (_) => SoundInputNoteFormCubit(),
        ),
        BlocProvider<SoundInputNoteBloc>(
          create: (_) => SoundInputNoteBloc(
            saveVoidingHistoryWithFileUsecase: getIt<SaveVoidingHistoryWithFileUsecase>(),
          ),
        ),
        BlocProvider<PendingUploadFileCubit>(
          create: (_) => PendingUploadFileCubit(),
        ),
      ],
      child: SoundInputNoteView(
        recorder: getIt<Recorder>(),
        recorderFile: recorderFile,
      ),
    );
  }
}
