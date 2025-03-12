import 'package:bladderly/domain/model/device_support_status.dart';
import 'package:bladderly/domain/usecase/check_supported_device_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'device_event.dart';
part 'device_state.dart';

class DeviceBloc extends HydratedBloc<DeviceEvent, DeviceState> {
  DeviceBloc({
    required CheckSupportedDeviceUsecase checkSupportedDeviceUsecase,
  })  : _checkSupportedDeviceUsecase = checkSupportedDeviceUsecase,
        super(DeviceInitial()) {
    on<DeviceCheckSupport>(_onCheckSupport);
  }

  final CheckSupportedDeviceUsecase _checkSupportedDeviceUsecase;

  Future<void> _onCheckSupport(DeviceCheckSupport event, Emitter<DeviceState> emit) async {
    emit(DeviceCheckSupportInProgress());

    final result = await _checkSupportedDeviceUsecase();

    result.fold(
      (exception) => emit(DeviceCheckSupportFailure(exception: exception)),
      (deviceSupportStatus) => emit(DeviceCheckSupportSuccess(deviceSupportStatus: deviceSupportStatus)),
    );
  }

  @override
  DeviceState? fromJson(Map<String, dynamic> json) {
    return switch (json['device_support_status']) {
      final String deviceSupportStatus =>
        DeviceCheckSupportSuccess(deviceSupportStatus: DeviceSupportStatus.values.byName(deviceSupportStatus)),
      _ => null,
    };
  }

  @override
  Map<String, dynamic>? toJson(DeviceState state) {
    if (state is! DeviceCheckSupportSuccess) return null;

    return {
      'device_support_status': state.deviceSupportStatus.name,
    };
  }
}
