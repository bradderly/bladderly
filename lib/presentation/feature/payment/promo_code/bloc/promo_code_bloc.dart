// Package imports:
// Project imports:
import 'package:bladderly/domain/model/promo_result.dart';
import 'package:bladderly/domain/usecase/check_promo_code_usecase.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'promo_code_event.dart';
part 'promo_code_state.dart';

class PromoCodeBloc extends Bloc<PromoCodeEvent, PromoCodeState> {
  PromoCodeBloc({
    required CheckPromoCodeUsecase checkPromoCodeUsecase,
  })  : _checkPromoCodeUsecase = checkPromoCodeUsecase,
        super(const PromoCodeInitial()) {
    on<PromoCodeEvent>(
      (event, emit) => switch (event) {
        PromoCodeCheck() => _onCheck(event, emit),
      },
      transformer: droppable(),
    );
  }

  final CheckPromoCodeUsecase _checkPromoCodeUsecase;

  Future<void> _onCheck(PromoCodeCheck event, Emitter<PromoCodeState> emit) async {
    emit(const PromoCodeCheckInProgress());

    final result = await _checkPromoCodeUsecase(userId: event.userId, code: event.code);

    result.fold(
      (exception) => emit(PromoCodeCheckFailure(exception: exception)),
      (promoResult) => emit(PromoCodeCheckSuccess(promoResult: promoResult)),
    );
  }
}
