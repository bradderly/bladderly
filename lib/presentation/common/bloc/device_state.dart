part of 'device_bloc.dart';

sealed class DeviceState extends Equatable {
  const DeviceState();

  @override
  List<Object> get props => [];
}

final class DeviceInitial extends DeviceState {}

final class DeviceCheckSupportInProgress extends DeviceState {}

final class DeviceCheckSupportSuccess extends DeviceState {
  const DeviceCheckSupportSuccess({
    required this.deviceSupportStatus,
  });

  final DeviceSupportStatus deviceSupportStatus;

  @override
  List<Object> get props => [
        deviceSupportStatus,
      ];
}

final class DeviceCheckSupportFailure extends DeviceState {
  const DeviceCheckSupportFailure({
    required this.exception,
  });

  final Exception exception;

  @override
  List<Object> get props => [
        ...super.props,
        exception,
      ];
}
