import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'passcode_state.dart';

class PasscodeCubit extends HydratedCubit<PasscodeState> {
  PasscodeCubit() : super(PasscodeState(isBiometricEnabled: false, passcode: ''));

  /// 생체 인증 활성화/비활성화
  void toggleBiometric(bool isEnabled) {
    emit(state.copyWith(isBiometricEnabled: isEnabled));
  }

  /// 패스코드 설정
  void setPasscode(String newPasscode) {
    emit(state.copyWith(passcode: newPasscode));
  }

  /// 패스코드 제거
  void clearPasscode() {
    emit(state.copyWith(passcode: ''));
  }

  @override
  PasscodeState? fromJson(Map<String, dynamic> json) {
    return PasscodeState(
      isBiometricEnabled: (json['isBiometricEnabled'] as bool?) ?? false, // ✅ 타입 캐스팅
      passcode: (json['passcode'] as String?) ?? '',
    );
  }

  @override
  Map<String, dynamic>? toJson(PasscodeState state) {
    return state.toJson();
  }
}
