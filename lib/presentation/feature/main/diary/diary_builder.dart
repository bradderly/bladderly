import 'package:bradderly/core/di/di.dart';
import 'package:bradderly/domain/usecase/get_histories_stream_usecase.dart';
import 'package:bradderly/domain/usecase/get_history_dates_stream_usecase.dart';
import 'package:bradderly/presentation/feature/main/cubit/main_tab_cubit.dart';
import 'package:bradderly/presentation/feature/main/diary/cubit/diary_cubit.dart';
import 'package:bradderly/presentation/feature/main/diary/cubit/diary_history_dates_cubit.dart';
import 'package:bradderly/presentation/feature/main/diary/diary_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiaryBuilder extends StatelessWidget {
  const DiaryBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              DiaryCubit(getHistoriesStreamUsecase: getIt<GetHistoriesStreamUsecase>())..subscribe(DateTime.now()),
        ),
        BlocProvider(
          create: (_) =>
              DiaryHistoryDatesCubit(getHistoryDatesStreamUsecase: getIt<GetHistoryDatesStreamUsecase>())..subscribe(),
        ),
        BlocProvider<MainTabCubit>.value(
          value: context.read<MainTabCubit>(),
        ),
      ],
      child: const DiaryView(),
    );
  }
}
