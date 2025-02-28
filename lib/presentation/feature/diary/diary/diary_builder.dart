import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/domain/usecase/get_histories_stream_usecase.dart';
import 'package:bladderly/domain/usecase/get_history_dates_stream_usecase.dart';
import 'package:bladderly/presentation/feature/diary/diary/cubit/diary_cubit.dart';
import 'package:bladderly/presentation/feature/diary/diary/cubit/diary_history_dates_cubit.dart';
import 'package:bladderly/presentation/feature/diary/diary/diary_view.dart';
import 'package:bladderly/presentation/feature/diary/diary/model/diary_tab_scroll_section_model.dart';
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
          create: (_) => DiaryCubit(
            dateTime: DateUtils.dateOnly(DateTime.now()),
            getHistoriesStreamUsecase: getIt<GetHistoriesStreamUsecase>(),
          ),
        ),
        BlocProvider<DiaryHistoryDatesCubit>(
          create: (_) =>
              DiaryHistoryDatesCubit(getHistoryDatesStreamUsecase: getIt<GetHistoryDatesStreamUsecase>())..subscribe(),
        ),
      ],
      child: DiaryView(diaryTabScrollSectionModel: diaryTabScrollSectionModel),
    );
  }
}
