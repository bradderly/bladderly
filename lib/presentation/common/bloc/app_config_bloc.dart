import 'package:bladderly/domain/model/app_config.dart';
import 'package:bladderly/domain/model/app_version.dart';
import 'package:bladderly/domain/usecase/load_app_config_usecase.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_config_event.dart';
part 'app_config_state.dart';

class AppConfigBloc extends Bloc<AppConfigEvent, AppConfigState> {
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
      (exception) => emit(AppConfigLoadFailure(exception: exception)),
      (appConfig) => emit(AppConfigLoadSuccess(appConfig: appConfig)),
    );
  }
}
