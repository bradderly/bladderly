part of 'plan_cancel_bloc.dart';

sealed class PlanCancelEvent extends Equatable {
  const PlanCancelEvent();

  @override
  List<Object> get props => [];
}

class PlanCancel extends PlanCancelEvent {
  const PlanCancel({
    required this.sample,
  });

  final String sample;

  @override
  List<Object> get props => [
        sample,
      ];
}
