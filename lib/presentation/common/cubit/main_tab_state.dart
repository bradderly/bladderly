part of 'main_tab_cubit.dart';

sealed class MainTabState extends Equatable {
  const MainTabState();

  int get index {
    return switch (this) {
      MainTabHome() => 0,
      MainTabDiary() => 1,
    };
  }

  @override
  List<Object> get props => [];
}

final class MainTabHome extends MainTabState {
  const MainTabHome();
}

final class MainTabDiary extends MainTabState {
  const MainTabDiary({
    required this.diaryTabScrollSectionModel,
    required this.checkRate,
  });

  final DiaryTabScrollSectionModel diaryTabScrollSectionModel;
  final bool checkRate;

  @override
  List<Object> get props => [
        ...super.props,
        diaryTabScrollSectionModel,
      ];
}
