import 'package:bladderly/domain/model/app_config.dart';
import 'package:bladderly/domain/model/app_version.dart';
import 'package:bladderly/domain/usecase/load_app_config_usecase.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:intl/intl.dart';

part 'app_config_event.dart';
part 'app_config_state.dart';

class AppConfigBloc extends HydratedBloc<AppConfigEvent, AppConfigState> {
  AppConfigBloc({
    required LoadAppConfigUsecase loadAppConfigUsecase,
  })  : _loadAppConfigUsecase = loadAppConfigUsecase,
        super(const AppConfigInitial()) {
    on<AppConfigLoad>(_onLoad, transformer: droppable());
  }

  final LoadAppConfigUsecase _loadAppConfigUsecase;

  Future<void> _onLoad(AppConfigLoad event, Emitter<AppConfigState> emit) async {
    emit(const AppConfigLoadInProgress());

    final result = await _loadAppConfigUsecase();

    result.fold(
      (exception) => emit(AppConfigLoadFailure(exception: exception, versionMap: state._versionMap)),
      (appConfig) => emit(
        AppConfigLoadSuccess(
          appConfig: appConfig,
          versionMap: {
            ...state._versionMap,
            appConfig.appVersion.currentVersion: DateTime.now().millisecondsSinceEpoch,
          },
        ),
      ),
    );
  }

  @override
  AppConfigState? fromJson(Map<String, dynamic> json) {
    return AppConfigInitial(
      versionMap: switch (json['app_version']) {
        final Map<String, int> versionMap => versionMap,
        _ => null,
      },
    );
  }

  @override
  Map<String, dynamic>? toJson(AppConfigState state) {
    return {
      'app_version': {
        ...state._versionMap,
      },
    };
  }
}
