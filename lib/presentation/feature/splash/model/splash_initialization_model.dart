import 'package:equatable/equatable.dart';

class SplashInitializationModel extends Equatable {
  const SplashInitializationModel({
    this.splashTime = false,
    this.appConfig = false,
    this.device = false,
    this.liveListen = false,
  });

  final bool splashTime;
  final bool appConfig;
  final bool device;
  final bool liveListen;

  SplashInitializationModel copyWith({
    bool? splashTime,
    bool? appConfig,
    bool? device,
    bool? liveListen,
  }) {
    return SplashInitializationModel(
      splashTime: splashTime ?? this.splashTime,
      appConfig: appConfig ?? this.appConfig,
      device: device ?? this.device,
      liveListen: liveListen ?? this.liveListen,
    );
  }

  bool get isAllInitialized => splashTime && appConfig && device && liveListen;

  @override
  List<Object?> get props => [
        splashTime,
        appConfig,
        device,
      ];
}
