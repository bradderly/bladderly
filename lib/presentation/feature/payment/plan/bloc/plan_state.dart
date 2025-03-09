part of 'plan_bloc.dart';

sealed class PlanState extends Equatable {
  const PlanState({
    this.plans = const [],
  });

  final List<Plan> plans;

  @override
  List<Object> get props => [
        plans,
      ];
}

final class PlanInitial extends PlanState {
  const PlanInitial();
}

final class PlanGetPlansInProgress extends PlanState {
  const PlanGetPlansInProgress();
}

final class PlanGetPlansSuccess extends PlanState {
  const PlanGetPlansSuccess({
    required super.plans,
  });
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
