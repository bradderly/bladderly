// Package imports:
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:bladderly/domain/usecase/paywall_usecase.dart';

part 'paywall_event.dart';
part 'paywall_state.dart';

class PaywallBloc extends Bloc<PaywallEvent, PaywallState> {
  PaywallBloc({required PaywallUsecase paywallUsecase})
      : _paywallUsecase = paywallUsecase,
        super(const PaywallInitial()) {
    on<PaywallEvent>(
      (event, emit) => switch (event) {
        Paywall() => null //_onChangePassord(event, emit),
      },
      transformer: droppable(),
    );
  }

  final PaywallUsecase _paywallUsecase;

/*
  Future<void> _onChangePassord(Paywall event, Emitter<PaywallState> emit) async {
    emit(const PaywallProgress());

    final result = await _paywallUsecase(
      email: event.sample,
      newPw: event.sample,
      oldPw: event.sample,
    );

    result.fold(
      (exception) => emit(PaywallFailure(exception: exception)),
      (success) => emit(const PaywallSuccess()),
    );
  }
*/
}
