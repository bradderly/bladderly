import 'package:bladderly/domain/model/plan.dart';
import 'package:bladderly/domain/usecase/get_paywall_plans_usecase.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'plan_event.dart';
part 'plan_state.dart';

class PlanBloc extends Bloc<PlanEvent, PlanState> {
  PlanBloc({
    required GetPaywallPlansUsecase getPaywallPlansUsecase,
  })  : _getPaywallPlansUsecase = getPaywallPlansUsecase,
        super(const PlanInitial()) {
    on<PlanGetPlans>(_onGetPlans, transformer: restartable());
  }

  final GetPaywallPlansUsecase _getPaywallPlansUsecase;

  Future<void> _onGetPlans(PlanGetPlans event, Emitter<PlanState> emit) async {
    emit(const PlanGetPlansInProgress());

    final result = await _getPaywallPlansUsecase();

    result.fold(
      (exception) => emit(PlanGetPlansFailure(exception: exception)),
      (plans) => emit(PlanGetPlansSuccess(plans: plans)),
    );
  }
}
