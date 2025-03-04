// Package imports:
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:bladderly/domain/model/unit.dart';

part 'menu_state.dart';

class MenuFormCubit extends Cubit<MenuFormState> {
  MenuFormCubit() : super(const MenuFormState()); // 기본값 ml

  void checkMl() {
    emit(state.copyWith(isMl: Unit.ml)); // 상태 업데이트
  }

  void checkOz() {
    emit(state.copyWith(isMl: Unit.oz)); // 상태 업데이트
  }
}
