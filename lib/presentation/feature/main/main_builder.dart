// Flutter imports:

// Project imports:
import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/core/recorder/recorder_module.dart';
import 'package:bladderly/domain/usecase/get_history_results_usecase.dart';
import 'package:bladderly/domain/usecase/upload_pending_histories_usecase.dart';
import 'package:bladderly/presentation/common/cubit/pending_upload_file_cubit.dart';
import 'package:bladderly/presentation/feature/main/bloc/main_history_bloc.dart';
import 'package:bladderly/presentation/feature/main/cubit/main_tab_cubit.dart';
import 'package:bladderly/presentation/feature/main/main_view.dart';
// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
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
        BlocProvider<MainHistoryBloc>(
          create: (_) => MainHistoryBloc(
            uploadPendingHistoriesUsecase: getIt<UploadPendingHistoriesUsecase>(),
            getProcessingHistoryResultsUsecase: getIt<GetHistoryResultsUsecase>(),
          ),
        ),
      ],
      child: MainView(
        recorderFileLoader: getIt<RecorderFileLoader>(),
      ),
    );
  }
}
