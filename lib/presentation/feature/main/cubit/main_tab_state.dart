part of 'main_tab_cubit.dart';

enum MainTabDiaryScrollScetion {
  voiding,
  intake,
  none,
  ;
}

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
    required this.scrollSection,
  });

  final MainTabDiaryScrollScetion scrollSection;

  @override
  List<Object> get props => [
        ...super.props,
        scrollSection,
      ];
}
