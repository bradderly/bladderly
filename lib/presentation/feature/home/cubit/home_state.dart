part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.showGuideTour = false,
    this.showHowToUse = false,
  });

  final bool showGuideTour;
  final bool showHowToUse;

  HomeState copyWith({
    bool? showGuideTour,
    bool? showHowToUse,
  }) {
    return HomeState(
      showGuideTour: showGuideTour ?? this.showGuideTour,
      showHowToUse: showHowToUse ?? this.showHowToUse,
    );
  }

  @override
  List<Object> get props => [
        showGuideTour,
        showHowToUse,
      ];
}
