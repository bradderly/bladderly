part of 'home_summary_cubit.dart';

class HomeSummaryState extends Equatable {
  const HomeSummaryState({
    this.voidingSummaryModel = const HomeVoidingSummaryModel.none(),
    this.intakeSummaryModel = const HomeIntakeSummaryModel.none(),
  });

  final HomeVoidingSummaryModel voidingSummaryModel;
  final HomeIntakeSummaryModel intakeSummaryModel;

  @override
  List<Object> get props => [
        voidingSummaryModel,
        intakeSummaryModel,
      ];
}
