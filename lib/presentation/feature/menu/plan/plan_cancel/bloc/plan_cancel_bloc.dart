import 'package:bladderly/domain/usecase/plan_cancel_usecase.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'plan_cancel_event.dart';
part 'plan_cancel_state.dart';

class PlanCancelBloc extends Bloc<PlanCancelEvent, PlanCancelState> {
  PlanCancelBloc({
    required PlanCancelUsecase planCancelUsecase,
  })  : _planCancelUsecase = planCancelUsecase,
        super(const PlanCancelInitial()) {
    on<PlanCancelEvent>(
      (event, emit) => switch (event) {
        PlanCancel() => null //_onChangePassord(event, emit),
      },
      transformer: droppable(),
    );
  }

  final PlanCancelUsecase _planCancelUsecase;

/*
  Future<void> _onChangePassord(PlanCancel event, Emitter<PlanCancelState> emit) async {
    emit(const PlanCancelProgress());

    final result = await _planCancelUsecase(
      email: event.sample,
      newPw: event.sample,
      oldPw: event.sample,
    );

    result.fold(
      (exception) => emit(PlanCancelFailure(exception: exception)),
      (success) => emit(const PlanCancelSuccess()),
    );
  }
*/
}
