part of 'export_dates_cubit.dart';

class ExportDatesState extends Equatable {
  const ExportDatesState({
    this.dates = const [],
  });

  final List<DateTime> dates;

  @override
  List<Object> get props => [
        dates,
      ];
}
