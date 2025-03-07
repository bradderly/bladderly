import 'package:bladderly/domain/model/app_version.dart';
import 'package:equatable/equatable.dart';

class AppConfig extends Equatable {
  const AppConfig({
    required this.appVersion,
  });

  final AppVersion appVersion;

  @override
  List<Object?> get props => [
        appVersion,
      ];
}
