import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bradderly/core/package_device_info/src/model/device_info_model.dart';
import 'package:bradderly/domain/model/sex.dart';
import 'package:bradderly/domain/usecase/signup_guest_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/v4.dart';

part 'signup_guest_event.dart';
part 'signup_guest_state.dart';

class SignupGuestBloc extends Bloc<SignupGuestEvent, SignupGuestState> {
  SignupGuestBloc({
    required UuidV4 uuidV4,
    required DeviceInfoModel deviceInfoModel,
    required SignupGuestUsecase signupGuestUsecase,
  })  : _signupGuestUsecase = signupGuestUsecase,
        _deviceInfoModel = deviceInfoModel,
        _uuidV4 = uuidV4,
        super(const SignupGuestInitial()) {
    on<SignupGuestSubmit>(_onSubmit, transformer: droppable());
  }

  final UuidV4 _uuidV4;
  final DeviceInfoModel _deviceInfoModel;
  final SignupGuestUsecase _signupGuestUsecase;

  Future<void> _onSubmit(SignupGuestSubmit event, Emitter<SignupGuestState> emit) async {
    emit(const SignupGuestSubmitInProgress());

    final result = await _signupGuestUsecase(
      userId: _uuidV4.generate(),
      gender: event.gender,
      yearOfBirth: event.yearOfBirth,
      region: _deviceInfoModel.region,
      device: _deviceInfoModel.name,
    );

    result.fold(
      (exception) => emit(SignupGuestSubmitFailure(exception: exception)),
      (user) => emit(const SignupGuestSubmitSuccess()),
    );
  }
}
