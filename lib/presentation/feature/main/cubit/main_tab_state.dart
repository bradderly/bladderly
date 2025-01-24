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
      MainTabHomeState() => 0,
      MainTabDiaryState() => 1,
    };
  }

  @override
  List<Object> get props => [];
}

final class MainTabHomeState extends MainTabState {
  const MainTabHomeState();
}

final class MainTabDiaryState extends MainTabState {
  const MainTabDiaryState({
    required this.scrollSection,
  });

  final MainTabDiaryScrollScetion scrollSection;

  @override
  List<Object> get props => [
        ...super.props,
        scrollSection,
      ];
}
