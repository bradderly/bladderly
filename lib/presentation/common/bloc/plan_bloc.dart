import 'dart:async';

import 'package:bladderly/domain/model/plan.dart';
import 'package:bladderly/domain/model/product.dart';
import 'package:bladderly/domain/usecase/get_paywall_plan_usecase.dart';
import 'package:bladderly/domain/usecase/get_paywall_plans_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'plan_event.dart';
part 'plan_state.dart';

class PlanBloc extends Bloc<PlanEvent, PlanState> {
  PlanBloc({
    required GetPaywallPlansUsecase getPaywallPlansUsecase,
    required GetPaywallPlanUsecase getPaywallPlanUsecase,
  })  : _getPaywallPlansUsecase = getPaywallPlansUsecase,
        _getPaywallPlanUsecase = getPaywallPlanUsecase,
        super(const PlanInitial()) {
    on<PlanGetPlans>(_onGetPlans);
    on<PlanGetPlanByOfferCode>(_onGetPlanByOfferCode);
  }

  final GetPaywallPlansUsecase _getPaywallPlansUsecase;
  final GetPaywallPlanUsecase _getPaywallPlanUsecase;

  Future<void> _onGetPlans(PlanGetPlans event, Emitter<PlanState> emit) async {
    emit(const PlanGetPlansInProgress());

    final result = await _getPaywallPlansUsecase(productTypes: event.productTypes);

    result.fold(
      (exception) {
        event.completer?.completeError(exception);
        emit(PlanGetPlansFailure(exception: exception));
      },
      (plans) {
        event.completer?.complete(plans);
        emit(PlanGetPlansSuccess(plans: plans));
      },
    );
  }

  Future<void> _onGetPlanByOfferCode(PlanGetPlanByOfferCode event, Emitter<PlanState> emit) async {
    emit(const PlanGetPlanByOfferCodeInProgress());

    final result = await _getPaywallPlanUsecase(offerCode: event.offerCode);

    result.fold(
      (exception) {
        event.completer?.completeError(exception);
        emit(PlanGetPlansFailure(exception: exception));
      },
      (plan) {
        event.completer?.complete(plan);
        emit(PlanGetPlanByOfferCodeSuccess(plan: plan));
      },
    );
  }
}
