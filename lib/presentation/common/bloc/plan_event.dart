part of 'plan_bloc.dart';

sealed class PlanEvent extends Equatable {
  const PlanEvent();

  @override
  List<Object?> get props => [];
}

class PlanGetPlans extends PlanEvent {
  const PlanGetPlans.onlyConsumable({
    this.offerCode,
  })  : productTypes = const [ProductType.consumable],
        completer = null;

  const PlanGetPlans.subscription({
    required Completer<List<Plan>> this.completer,
    this.offerCode,
  }) : productTypes = const [ProductType.renewalSubscription, ProductType.nonRenewalSubscription];

  final List<ProductType> productTypes;
  final Completer<List<Plan>>? completer;

  final String? offerCode;

  @override
  List<Object?> get props => [
        productTypes,
        completer,
        offerCode,
      ];
}

class PlanGetPlanByOfferCode extends PlanEvent {
  const PlanGetPlanByOfferCode({
    required this.offerCode,
    this.completer,
  });

  final String offerCode;
  final Completer? completer;

  @override
  List<Object?> get props => [
        offerCode,
        completer,
      ];
}
