part of 'passcode_cubit.dart';

class PasscodeState {
  PasscodeState({
    required this.isLocked,
    required this.passcode,
  });

  static PasscodeState? fromJson(Map<String, dynamic> map) {
    final isLocked = switch (map['isLocked']) {
      final bool isLocked => isLocked,
      _ => null,
    };

    final passcord = switch (map['passcode']) {
      final String passcode => passcode,
      _ => null,
    };

    if (isLocked == null || passcord == null) return null;

    return PasscodeState(
      isLocked: isLocked,
      passcode: passcord,
    );
  }

  final bool isLocked;
  final String passcode;

  /// JSON 변환을 위한 copyWith
  PasscodeState copyWith({
    bool? isLocked,
    String? passcode,
  }) {
    return PasscodeState(
      isLocked: isLocked ?? this.isLocked,
      passcode: passcode ?? this.passcode,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isLocked': isLocked,
      'passcode': passcode,
    };
  }
}
