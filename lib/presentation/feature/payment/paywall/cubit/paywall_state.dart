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
