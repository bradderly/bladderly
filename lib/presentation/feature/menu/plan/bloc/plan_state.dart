part of 'plan_bloc.dart';

sealed class PlanState extends Equatable {
  const PlanState();

  @override
  List<Object> get props => [];
}

final class PlanInitial extends PlanState {
  const PlanInitial();
}

final class PlanProgress extends PlanState {
  const PlanProgress();
}

final class PlanSuccess extends PlanState {
  const PlanSuccess();
}

final class PlanFailure extends PlanState {
  const PlanFailure({
    required this.exception,
  });

  final Exception exception;

  @override
  List<Object> get props => [
        ...super.props,
        exception,
      ];
}
