part of 'paywall_bloc.dart';

sealed class PaywallEvent extends Equatable {
  const PaywallEvent();

  @override
  List<Object> get props => [];
}

class Paywall extends PaywallEvent {
  const Paywall({
    required this.sample,
  });

  final String sample;

  @override
  List<Object> get props => [
        sample,
      ];
}
