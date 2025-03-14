// Flutter imports:
import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/domain/usecase/get_history_dates_stream_usecase.dart';
// Project imports:
import 'package:bladderly/presentation/feature/export/calendar/cubit/export_dates_cubit.dart';
import 'package:bladderly/presentation/feature/export/calendar/export_calendar_view.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

class ExportCalendarBuilder extends StatelessWidget {
  const ExportCalendarBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ExportDatesCubit>(
      create: (_) => ExportDatesCubit(
        getHistoryDatesStreamUsecase: getIt<GetHistoryDatesStreamUsecase>(),
      )..subscribe(),
      child: ExportCalendarView(),
    );
  }
}
