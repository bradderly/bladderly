part of 'app_config_bloc.dart';

sealed class AppConfigEvent extends Equatable {
  const AppConfigEvent();

  @override
  List<Object> get props => [];
}

class AppConfigLoad extends AppConfigEvent {
  const AppConfigLoad();
}
