part of 'menu_cubit.dart';

class MenuFormState extends Equatable {
  const MenuFormState({
    this.isMl = Unit.ml,
    this.latestVersion = '1.0.0',
  });

  final Unit isMl;
  final String latestVersion;

  MenuFormState copyWith({
    Unit? isMl,
    String? latestVersion,
  }) {
    return MenuFormState(
      isMl: this.isMl,
      latestVersion: this.latestVersion,
    );
  }

  @override
  List<Object> get props => [
        isMl,
        latestVersion,
      ];
}
