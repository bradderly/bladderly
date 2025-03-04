import 'package:bladderly/domain/usecase/contact_us_usecase.dart';
import 'package:bladderly/domain/usecase/plan_usecase.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'plan_event.dart';
part 'plan_state.dart';

class PlanBloc extends Bloc<PlanEvent, PlanState> {
  PlanBloc({
    required PlanUsecase planUsecase,
  })  : _planUsecase = planUsecase,
        super(const PlanInitial()) {
    on<PlanEvent>(
      (event, emit) => switch (event) {
        Plan() => null //_onChangePassord(event, emit),
      },
      transformer: droppable(),
    );
  }

  final PlanUsecase _planUsecase;

/*
  Future<void> _onChangePassord(Plan event, Emitter<PlanState> emit) async {
    emit(const PlanProgress());

    final result = await _planUsecase(
      email: event.sample,
      newPw: event.sample,
      oldPw: event.sample,
    );

    result.fold(
      (exception) => emit(PlanFailure(exception: exception)),
      (success) => emit(const PlanSuccess()),
    );
  }
*/
}
