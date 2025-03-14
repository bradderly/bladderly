part of 'membership_bloc.dart';

sealed class MembershipState extends Equatable {
  const MembershipState({
    this.membership,
    DateTime? lastInitializedAt,
  }) : _lastInitializedAt = lastInitializedAt;

  final Membership? membership;
  final DateTime? _lastInitializedAt;

  bool get isValidMembership => membership?.isValid ?? false;

  @override
  List<Object?> get props => [
        membership,
        _lastInitializedAt,
      ];
}

final class MembershipInitial extends MembershipState {
  const MembershipInitial({
    super.membership,
    super.lastInitializedAt,
  });
}

final class MembershipLoadSuccess extends MembershipState {
  const MembershipLoadSuccess({
    required super.membership,
    required super.lastInitializedAt,
  });
}

final class MembershipLoadFailure extends MembershipState {
  const MembershipLoadFailure({
    required super.membership,
    required super.lastInitializedAt,
    required this.exception,
  });

  final Exception exception;

  @override
  List<Object?> get props => [
        ...super.props,
        exception,
      ];
}

final class MembershipInitializeInProgress extends MembershipState {
  const MembershipInitializeInProgress({
    required super.membership,
    required super.lastInitializedAt,
  });
}

final class MembershipInitializeSuccess extends MembershipState {
  const MembershipInitializeSuccess({
    required super.membership,
    required super.lastInitializedAt,
  });
}

final class MembershipInitializeFailure extends MembershipState {
  const MembershipInitializeFailure({
    required super.membership,
    required super.lastInitializedAt,
    required this.exception,
  });

  final Exception exception;

  @override
  List<Object?> get props => [
        ...super.props,
        exception,
      ];
}
