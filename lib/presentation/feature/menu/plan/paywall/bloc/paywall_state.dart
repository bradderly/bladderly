part of 'paywall_bloc.dart';

sealed class PaywallState extends Equatable {
  const PaywallState();

  @override
  List<Object> get props => [];
}

final class PaywallInitial extends PaywallState {
  const PaywallInitial();
}

final class PaywallProgress extends PaywallState {
  const PaywallProgress();
}

final class PaywallSuccess extends PaywallState {
  const PaywallSuccess();
}

final class PaywallFailure extends PaywallState {
  const PaywallFailure({
    required this.exception,
  });

  final Exception exception;

  @override
  List<Object> get props => [
        ...super.props,
        exception,
      ];
}
