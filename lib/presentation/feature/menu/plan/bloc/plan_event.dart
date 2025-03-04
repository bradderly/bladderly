part of 'plan_bloc.dart';

sealed class PlanEvent extends Equatable {
  const PlanEvent();

  @override
  List<Object> get props => [];
}

class Plan extends PlanEvent {
  const Plan({
    required this.sample,
  });

  final String sample;

  @override
  List<Object> get props => [
        sample,
      ];
}
