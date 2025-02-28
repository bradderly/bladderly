import 'package:bladderly/presentation/feature/diary/diary/model/diary_tab_scroll_section_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_tab_state.dart';

class MainTabCubit extends Cubit<MainTabState> {
  MainTabCubit() : super(const MainTabHome());

  void showIndex(int index) {
    return switch (index) {
      0 => showHome(),
      1 => showDiary(),
      _ => null,
    };
  }

  void showHome() {
    emit(const MainTabHome());
  }

  void showDiary({DiaryTabScrollSectionModel scrollSection = DiaryTabScrollSectionModel.none}) {
    emit(MainTabDiary(diaryTabScrollSectionModel: scrollSection));
  }

  void switchByTabName(String? tabName) {
    return switch (tabName) {
      'home' => showHome(),
      'diary' => showDiary(),
      _ => null,
    };
  }
}
