part of 'export_dates_cubit.dart';

class ExportDatesState extends Equatable {
  const ExportDatesState({
    this.historyDates = const [],
    this.selectedDates = const [],
  });

  final List<DateTime> historyDates;

  final List<DateTime> selectedDates;

  ExportDatesState copyWith({
    List<DateTime>? dates,
    List<DateTime>? selectedDates,
  }) {
    return ExportDatesState(
      historyDates: dates ?? this.historyDates,
      selectedDates: selectedDates ?? this.selectedDates,
    );
  }

  @override
  List<Object> get props => [
        historyDates,
        selectedDates,
      ];
}
