part of 'diary_history_dates_cubit.dart';

class DiaryHistoryDatesState extends Equatable {
  const DiaryHistoryDatesState({
    this.dates = const [],
  });

  final List<DateTime> dates;

  bool hasHistory(DateTime date) => dates.contains(date);

  @override
  List<Object> get props => [
        dates,
      ];
}
