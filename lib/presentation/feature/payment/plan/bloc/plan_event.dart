part of 'plan_bloc.dart';

sealed class PlanEvent extends Equatable {
  const PlanEvent();

  @override
  List<Object> get props => [];
}

class PlanGetPlans extends PlanEvent {
  const PlanGetPlans();
}
