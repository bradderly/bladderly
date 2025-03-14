part of 'membership_bloc.dart';

sealed class MembershipEvent extends Equatable {
  const MembershipEvent();

  @override
  List<Object> get props => [];
}

class MembershipLoad extends MembershipEvent {
  const MembershipLoad({
    required this.userId,
  });

  final String userId;

  @override
  List<Object> get props => [
        userId,
      ];
}

class MembershipInitialize extends MembershipEvent {
  const MembershipInitialize({
    required this.userId,
  });

  final String userId;

  @override
  List<Object> get props => [
        super.props,
      ];
}
