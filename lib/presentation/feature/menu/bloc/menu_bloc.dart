// Package imports:
import 'package:bladderly/domain/usecase/get_version_usecase.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc({
    required GetVersionUsecase getVersionUsecase,
  })  : _getVersionUsecase = getVersionUsecase,
        super(const MenuInitial()) {
    on<MenuEvent>(
      (event, emit) => switch (event) {
        GetVersion() => _onGetVersion(event, emit),
      },
      transformer: droppable(),
    );
  }

  final GetVersionUsecase _getVersionUsecase;

  Future<void> _onGetVersion(GetVersion event, Emitter<MenuState> emit) async {
    emit(const MenuInProgress());

    final result = await _getVersionUsecase(
      device: event.device,
    );

    result.fold(
      (exception) => emit(GetVersionFailure(exception: exception)),
      (success) {
        final latestVersion = success.latestVersion.toString(); // success에서 latest_version 추출
        emit(GetVersionSuccess(latestVersion: latestVersion)); // 최신 버전 상태로 emit
      },
    );
  }
}
