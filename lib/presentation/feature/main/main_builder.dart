import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/core/recorder/recorder_module.dart';
import 'package:bladderly/presentation/common/bloc/user_bloc.dart';
import 'package:bladderly/presentation/common/cubit/pending_upload_file_cubit.dart';
import 'package:bladderly/presentation/feature/main/cubit/main_tab_cubit.dart';
import 'package:bladderly/presentation/feature/main/main_view.dart';
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
        BlocProvider<UserBloc>.value(
          value: context.read<UserBloc>(),
        ),
      ],
      child: MainView(
        recorder: getIt<Recorder>(),
      ),
    );
  }
}
