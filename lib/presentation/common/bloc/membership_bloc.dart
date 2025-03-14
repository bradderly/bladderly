import 'package:bladderly/domain/model/membership.dart';
import 'package:bladderly/domain/usecase/get_membership_stream_usecase.dart';
import 'package:bladderly/domain/usecase/initialize_membership_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'membership_event.dart';
part 'membership_state.dart';

class MembershipBloc extends HydratedBloc<MembershipEvent, MembershipState> {
  MembershipBloc({
    required GetMembershipStreamUsecase getMembershipStreamUsecase,
    required InitializeMembershipUsecase initializeMembershipUsecase,
  })  : _getMembershipStreamUsecase = getMembershipStreamUsecase,
        _initializeMembershipUsecase = initializeMembershipUsecase,
        super(const MembershipInitial()) {
    on<MembershipLoad>(_onLoad);
    on<MembershipInitialize>(_onInitialize);
  }

  final GetMembershipStreamUsecase _getMembershipStreamUsecase;
  final InitializeMembershipUsecase _initializeMembershipUsecase;

  void _onLoad(MembershipLoad event, Emitter<MembershipState> emit) {
    return _getMembershipStreamUsecase(event.userId).fold(
      (exception) => emit(
        MembershipLoadFailure(
          membership: state.membership,
          lastInitializedAt: state._lastInitializedAt,
          exception: exception,
        ),
      ),
      (stream) => emit.forEach<Membership?>(
        stream,
        onData: (membership) => MembershipLoadSuccess(
          membership: membership,
          lastInitializedAt: DateTime.now(),
        ),
        onError: (e, s) => MembershipLoadFailure(
          membership: state.membership,
          lastInitializedAt: state._lastInitializedAt,
          exception: e is Exception ? e : Exception(e.toString()),
        ),
      ),
    );
  }

  Future<void> _onInitialize(MembershipInitialize event, Emitter<MembershipState> emit) async {
    if (DateUtils.isSameDay(state._lastInitializedAt, DateTime.now())) return;

    emit(MembershipInitializeInProgress(membership: state.membership, lastInitializedAt: state._lastInitializedAt));

    final result = await _initializeMembershipUsecase(userId: event.userId);

    result.fold(
      (exception) => emit(
        MembershipInitializeFailure(
          membership: state.membership,
          lastInitializedAt: state._lastInitializedAt,
          exception: exception,
        ),
      ),
      (membership) => emit(
        MembershipInitializeSuccess(
          membership: membership,
          lastInitializedAt: DateTime.now(),
        ),
      ),
    );
  }

  @override
  MembershipState? fromJson(Map<String, dynamic> json) {
    if (json['last_initialized_at'] case final int milliseconds) {
      return MembershipInitial(lastInitializedAt: DateTime.fromMillisecondsSinceEpoch(milliseconds));
    }

    return null;
  }

  @override
  Map<String, dynamic>? toJson(MembershipState state) {
    return {
      'last_initialized_at': state._lastInitializedAt?.millisecondsSinceEpoch,
    };
  }
}
