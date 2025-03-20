import 'package:equatable/equatable.dart';

class AppVersion extends Equatable {
  const AppVersion({
    required this.minVersion,
    required this.latestVersion,
    required this.currentVersion,
    required this.currentBuild,
  });

  const AppVersion.empty({
    required this.currentVersion,
    required this.currentBuild,
  })  : minVersion = currentVersion,
        latestVersion = currentVersion;

  final String minVersion;
  final String latestVersion;
  final String currentVersion;
  final String currentBuild;

  @override
  List<Object?> get props => [
        minVersion,
        latestVersion,
        currentVersion,
        currentBuild,
      ];
}
