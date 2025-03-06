import 'package:bladderly/domain/usecase/check_supported_device_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc({
    required CheckSupportedDeviceUsecase checkSupportedDeviceUsecase,
  })  : _checkSupportedDeviceUsecase = checkSupportedDeviceUsecase,
        super(SplashInitial()) {
    on<SplashCheckSupportedDevice>(_onCheckSupportedDevice);
  }

  final CheckSupportedDeviceUsecase _checkSupportedDeviceUsecase;

  Future<void> _onCheckSupportedDevice(SplashCheckSupportedDevice event, Emitter<SplashState> emit) async {
    emit(SplashCheckSupportedDeviceInProgress());

    final result = await _checkSupportedDeviceUsecase();

    result.fold(
      (exception) => emit(SplashCheckSupportedDeviceFailure(exception: exception)),
      (_) => emit(SplashCheckSupportedDeviceSuccess()),
    );
  }
}
