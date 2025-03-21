part of 'plan_bloc.dart';

sealed class PlanState extends Equatable {
  const PlanState();

  @override
  List<Object> get props => [];
}

final class PlanInitial extends PlanState {
  const PlanInitial();
}

final class PlanGetPlansInProgress extends PlanState {
  const PlanGetPlansInProgress();
}

final class PlanGetPlansSuccess extends PlanState {
  const PlanGetPlansSuccess({
    required this.plans,
  });

  final List<Plan> plans;

  @override
  List<Object> get props => [
        ...super.props,
        plans,
      ];
}

final class PlanGetPlansFailure extends PlanState {
  const PlanGetPlansFailure({
    required this.exception,
  });

  final Exception exception;

  @override
  List<Object> get props => [
        ...super.props,
        exception,
      ];
}

final class PlanGetPlanByOfferCodeInProgress extends PlanState {
  const PlanGetPlanByOfferCodeInProgress();
}

final class PlanGetPlanByOfferCodeSuccess extends PlanState {
  const PlanGetPlanByOfferCodeSuccess({
    required this.plan,
  });

  final Plan plan;

  @override
  List<Object> get props => [
        ...super.props,
        plan,
      ];
}

final class PlanGetPlanByOfferCodeFailure extends PlanState {
  const PlanGetPlanByOfferCodeFailure({
    required this.exception,
  });

  final Exception exception;

  @override
  List<Object> get props => [
        ...super.props,
        exception,
      ];
}
