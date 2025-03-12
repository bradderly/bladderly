part of 'device_bloc.dart';

sealed class DeviceEvent extends Equatable {
  const DeviceEvent();

  @override
  List<Object> get props => [];
}

class DeviceCheckSupport extends DeviceEvent {
  const DeviceCheckSupport();
}
