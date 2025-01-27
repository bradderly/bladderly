import 'package:bradderly/presentation/feature/export/calendar/cubit/export_dates_cubit.dart';
import 'package:bradderly/presentation/feature/export/calendar/export_calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocProvider(
      create: (_) => ExportDatesCubit(),
      child: ExportCalendarView(
        onTapNext: onTapNext,
        historyDates: historyDates,
      ),
    );
  }
}
