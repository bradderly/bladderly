// Package imports:
// Project imports:
import 'package:bladderly/domain/usecase/check_promo_code_usecase.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'promo_code_event.dart';
part 'promo_code_state.dart';

class PromoCodeBloc extends Bloc<PromoCodeEvent, PromoCodeState> {
  PromoCodeBloc({
    required CheckPromoCodeUsecase promoCodeUsecase,
  })  : _promoCodeUsecase = promoCodeUsecase,
        super(const PromoCodeInitial()) {
    on<PromoCodeEvent>(
      (event, emit) => switch (event) {
        PromoCode() => null //_onChangePassord(event, emit),
      },
      transformer: droppable(),
    );
  }

  final CheckPromoCodeUsecase _promoCodeUsecase;

  Future<void> _checkPromo(PromoCode event, Emitter<PromoCodeState> emit) async {
    emit(const PromoCodeProgress());

    final result = await _promoCodeUsecase(userId: event.userId, code: event.code);

    result.fold(
      (exception) => emit(PromoCodeFailure(exception: exception)),
      (success) => emit(const PromoCodeSuccess()),
    );
  }
}
