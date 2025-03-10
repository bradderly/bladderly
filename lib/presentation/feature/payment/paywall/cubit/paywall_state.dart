part of 'paywall_cubit.dart';

class PaywallState extends Equatable {
  const PaywallState({
    this.selectedPlanId,
  });

  final String? selectedPlanId;

  bool get isValid => selectedPlanId != null;

  PaywallState copyWith({
    String? selectedPlanId,
  }) {
    return PaywallState(
      selectedPlanId: selectedPlanId ?? this.selectedPlanId,
    );
  }

  @override
  List<Object?> get props => [
        selectedPlanId,
      ];
}

// final class PaywallPurchasePlanInProgress extends PaywallState {}

// final class PaywallPurchasePlanSuccess extends PaywallState {}

// final class PaywallPurchasePlanFailure extends PaywallState {
//   const PaywallPurchasePlanFailure({
//     required this.exception,
//   });

//   final Exception exception;

//   @override
//   List<Object> get props => [
//         exception,
//       ];
// }
