import 'package:bradderly/core/di/di.dart';
import 'package:bradderly/domain/usecase/get_histories_stream_usecase.dart';
import 'package:bradderly/domain/usecase/get_history_dates_stream_usecase.dart';
import 'package:bradderly/presentation/feature/diary/diary/cubit/diary_cubit.dart';
import 'package:bradderly/presentation/feature/diary/diary/cubit/diary_history_dates_cubit.dart';
import 'package:bradderly/presentation/feature/diary/diary/diary_view.dart';
import 'package:bradderly/presentation/feature/diary/diary/model/diary_tab_scroll_section_model.dart';
import 'package:bradderly/presentation/feature/main/cubit/main_tab_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiaryBuilder extends StatelessWidget {
  const DiaryBuilder({
    super.key,
    required this.diaryTabScrollSectionModel,
  });

  final DiaryTabScrollSectionModel? diaryTabScrollSectionModel;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DiaryCubit>(
          create: (_) =>
              DiaryCubit(getHistoriesStreamUsecase: getIt<GetHistoriesStreamUsecase>())..subscribe(DateTime.now()),
        ),
        BlocProvider<DiaryHistoryDatesCubit>(
          create: (_) =>
              DiaryHistoryDatesCubit(getHistoryDatesStreamUsecase: getIt<GetHistoryDatesStreamUsecase>())..subscribe(),
        ),
        BlocProvider<MainTabCubit>.value(
          value: context.read<MainTabCubit>(),
        ),
      ],
      child: DiaryView(diaryTabScrollSectionModel: diaryTabScrollSectionModel),
    );
  }
}
