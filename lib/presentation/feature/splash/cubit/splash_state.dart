part of 'splash_cubit.dart';

final class SplashState extends Equatable {
  const SplashState({
    String? latestCheckVersion,
  }) : _latestCheckVersion = latestCheckVersion;

  final String? _latestCheckVersion;

  bool isAlreadyChecked(String version) => _latestCheckVersion == version;

  @override
  List<Object?> get props => [
        _latestCheckVersion,
      ];
}
