// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:bladderly/presentation/feature/export/calendar/cubit/export_dates_cubit.dart';
import 'package:bladderly/presentation/feature/export/calendar/export_calendar_view.dart';

class ExportCalendarBuilder extends StatelessWidget {
  const ExportCalendarBuilder({
    super.key,
    required this.onTapNext,
    required this.historyDates,
  });

  final void Function(List<DateTime>) onTapNext;

  final List<DateTime> historyDates;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ExportDatesCubit>(
      create: (_) => ExportDatesCubit(),
      child: ExportCalendarView(
        onTapNext: onTapNext,
        historyDates: historyDates,
      ),
    );
  }
}
