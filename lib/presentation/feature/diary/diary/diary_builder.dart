import 'package:bradderly/core/di/di.dart';
import 'package:bradderly/domain/usecase/get_histories_stream_usecase.dart';
import 'package:bradderly/presentation/feature/diary/diary/cubit/diary_cubit.dart';
import 'package:bradderly/presentation/feature/diary/diary/diary_view.dart';
import 'package:bradderly/presentation/feature/diary/diary/model/diary_view_scroll_section_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiaryBuilder extends StatelessWidget {
  const DiaryBuilder({
    super.key,
    required this.scrollSection,
    required this.onApplyScrollSection,
  });

  final DiaryViewScrollSectionModel scrollSection;
  final VoidCallback onApplyScrollSection;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          DiaryCubit(getHistoriesStreamUsecase: getIt<GetHistoriesStreamUsecase>())..subscribe(DateTime.now()),
      child: DiaryView(
        scrollSection: scrollSection,
        onApplyScrollSection: onApplyScrollSection,
      ),
    );
  }
}
