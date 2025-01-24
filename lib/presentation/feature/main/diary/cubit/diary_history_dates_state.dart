part of 'diary_history_dates_cubit.dart';

class DiaryHistoryDatesState extends Equatable {
  const DiaryHistoryDatesState({
    List<DateTime> dates = const [],
  }) : _dates = dates;

  final List<DateTime> _dates;

  bool hasHistory(DateTime date) => _dates.contains(date);

  @override
  List<Object> get props => [
        _dates,
      ];
}
