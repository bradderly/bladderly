// Package imports:
import 'package:hydrated_bloc/hydrated_bloc.dart';

// Project imports:
import 'package:bladderly/domain/model/unit.dart';

class UnitCubit extends HydratedCubit<Unit> {
  UnitCubit() : super(Unit.ml);

  void change(Unit unit) {
    emit(unit);
  }

  @override
  Unit? fromJson(Map<String, dynamic> json) {
    return switch (json['unit']) {
      final String unit => Unit.values.byName(unit),
      _ => null,
    };
  }

  @override
  Map<String, dynamic>? toJson(Unit state) {
    return {
      'unit': state.name,
    };
  }
}
