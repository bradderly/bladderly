part of 'plan_bloc.dart';

sealed class PlanEvent extends Equatable {
  const PlanEvent();

  @override
  List<Object> get props => [];
}

class PlanGetPlans extends PlanEvent {
  const PlanGetPlans.onlyConsumable() : productTypes = const [ProductType.consumable];

  const PlanGetPlans.subscription()
      : productTypes = const [ProductType.renewalSubscription, ProductType.nonRenewalSubscription];

  final List<ProductType> productTypes;

  @override
  List<Object> get props => [
        productTypes,
      ];
}
