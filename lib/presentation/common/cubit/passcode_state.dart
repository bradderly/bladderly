part of 'passcode_cubit.dart';

class PasscodeState {
  PasscodeState({required this.isBiometricEnabled, required this.passcode});
  final bool isBiometricEnabled;
  final String passcode;

  /// JSON 변환을 위한 copyWith
  PasscodeState copyWith({bool? isBiometricEnabled, String? passcode}) {
    return PasscodeState(
      isBiometricEnabled: isBiometricEnabled ?? this.isBiometricEnabled,
      passcode: passcode ?? this.passcode,
    );
  }

  /// JSON 변환 (저장용)
  Map<String, dynamic> toJson() {
    return {
      'isBiometricEnabled': isBiometricEnabled,
      'passcode': passcode,
    };
  }
}
