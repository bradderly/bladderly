import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'home_state.dart';

class HomeCubit extends HydratedCubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void onShowGuideTour() {
    emit(state.copyWith(showGuideTour: true));
  }

  void onShowHowToUse() {
    emit(state.copyWith(showHowToUse: true));
  }

  @override
  Future<void> clear() {
    emit(const HomeState());

    return super.clear();
  }

  @override
  HomeState? fromJson(Map<String, dynamic> json) {
    return HomeState(
      showGuideTour: json['show_guide_tour'] == true,
      showHowToUse: json['show_how_to_use'] == true,
    );
  }

  @override
  Map<String, dynamic>? toJson(HomeState state) {
    return {
      'show_guide_tour': state.showGuideTour,
      'show_how_to_use': state.showHowToUse,
    };
  }
}
