part of 'diary_cubit.dart';

class DiaryState extends Equatable {
  const DiaryState({
    required this.dateTime,
    this.diaryVoidingSummaryModel = const DiaryVoidingSummaryModel.none(),
    this.diaryIntakeSummaryModel = const DiaryIntakeSummaryModel.none(),
    this.diaryHistoryModels = const [],
  });

  final DateTime dateTime;
  final DiaryVoidingSummaryModel diaryVoidingSummaryModel;
  final DiaryIntakeSummaryModel diaryIntakeSummaryModel;
  final List<DiaryHistoryModel> diaryHistoryModels;

  @override
  List<Object> get props => [
        dateTime,
        diaryVoidingSummaryModel,
        diaryIntakeSummaryModel,
        diaryHistoryModels,
      ];
}
