import 'package:bradderly/core/di/di.dart';
import 'package:bradderly/core/recorder/recorder_module.dart';
import 'package:bradderly/presentation/common/cubit/pending_upload_file_cubit.dart';
import 'package:bradderly/presentation/feature/main/cubit/main_tab_cubit.dart';
import 'package:bradderly/presentation/feature/main/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainBuilder extends StatelessWidget {
  const MainBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainTabCubit>(
          create: (_) => MainTabCubit(),
        ),
        BlocProvider<PendingUploadFileCubit>(
          create: (_) => PendingUploadFileCubit(),
        ),
      ],
      child: MainView(
        recorder: getIt<Recorder>(),
      ),
    );
  }
}
