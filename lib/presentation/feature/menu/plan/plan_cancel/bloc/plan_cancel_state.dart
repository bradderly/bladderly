part of 'plan_cancel_bloc.dart';

sealed class PlanCancelState extends Equatable {
  const PlanCancelState();

  @override
  List<Object> get props => [];
}

final class PlanCancelInitial extends PlanCancelState {
  const PlanCancelInitial();
}

final class PlanCancelProgress extends PlanCancelState {
  const PlanCancelProgress();
}

final class PlanCancelSuccess extends PlanCancelState {
  const PlanCancelSuccess();
}

final class PlanCancelFailure extends PlanCancelState {
  const PlanCancelFailure({
    required this.exception,
  });

  final Exception exception;

  @override
  List<Object> get props => [
        ...super.props,
        exception,
      ];
}
