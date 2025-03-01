// Package imports:
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'export_dates_state.dart';

class ExportDatesCubit extends Cubit<ExportDatesState> {
  ExportDatesCubit() : super(const ExportDatesState());

  void select(DateTime date) {
    final hasDate = state.dates.contains(date);

    if (hasDate && state.dates.length >= 7) {
      return;
    }

    final dates = List<DateTime>.from(state.dates);

    if (hasDate) {
      dates.remove(date);
    } else {
      dates.add(date);
    }

    emit(ExportDatesState(dates: dates));
  }
}
