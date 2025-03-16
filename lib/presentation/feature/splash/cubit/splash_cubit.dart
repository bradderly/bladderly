import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'splash_state.dart';

class SplashCubit extends HydratedCubit<SplashState> {
  SplashCubit() : super(const SplashState());

  void onCheckVersion(String version) {
    emit(SplashState(latestCheckVersion: version));
  }

  @override
  SplashState? fromJson(Map<String, dynamic> json) {
    return SplashState(
      latestCheckVersion: switch (json['latest_check_version']) {
        final String latestCheckVersion => latestCheckVersion,
        _ => null,
      },
    );
  }

  @override
  Map<String, dynamic>? toJson(SplashState state) {
    return {
      'latest_check_version': state._latestCheckVersion,
    };
  }
}
