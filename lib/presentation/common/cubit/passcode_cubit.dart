import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'passcode_state.dart';

class PasscodeCubit extends HydratedCubit<PasscodeState> {
  PasscodeCubit() : super(PasscodeState(isLocked: false, passcode: ''));

  /// 잠금 설정
  void lock({
    required String passcode,
  }) {
    emit(state.copyWith(isLocked: true, passcode: passcode));
  }

  void unlock() {
    emit(state.copyWith(isLocked: false));
  }

  @override
  PasscodeState? fromJson(Map<String, dynamic> json) {
    return PasscodeState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(PasscodeState state) {
    return state.toJson();
  }
}
