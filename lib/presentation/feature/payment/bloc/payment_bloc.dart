import 'package:bladderly/domain/model/product.dart';
import 'package:bladderly/domain/usecase/initialize_purchase_handler_usecase.dart';
import 'package:bladderly/domain/usecase/purchase_plan_usecase.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc({
    required InitializePurchaseHandlerUsecase initializePurchaseHandlerUsecase,
    required PurchasePlanUsecase purchasePlanUsecase,
  })  : _initializePurchaseHandlerUsecase = initializePurchaseHandlerUsecase,
        _purchasePlanUsecase = purchasePlanUsecase,
        super(const PaymentInitial()) {
    on<PaymentInitializeHandler>(_onInitializeHandler);
    on<PaymentPurchasePlan>(_onPurchasePlan, transformer: droppable());
  }

  final InitializePurchaseHandlerUsecase _initializePurchaseHandlerUsecase;
  final PurchasePlanUsecase _purchasePlanUsecase;

  void _onInitializeHandler(PaymentInitializeHandler event, Emitter<PaymentState> emit) {
    emit(const PaymentInitializeHandlerInProgress());

    return _initializePurchaseHandlerUsecase(userId: event.userId).fold(
      (exception) => emit(PaymentInitializeHandlerFailure(exception: exception)),
      (stream) => emit.forEach<PurchaseStatus?>(
        stream,
        onData: (status) => switch (status) {
          PurchaseStatus.pending => const PaymentPurchaseInProgress(),
          PurchaseStatus.purchased => const PaymentPurchaseSuccess(),
          PurchaseStatus.error => PaymentPurchaseFailure(exception: Exception('purchase failed')),
          PurchaseStatus.restored => const PaymentPurchaseRestored(),
          PurchaseStatus.canceled => const PaymentPurchaseCanceled(),
          null => const PaymentInitial(),
        },
        onError: (e, s) => PaymentPurchaseFailure(exception: e is Exception ? e : Exception(e.toString())),
      ),
    );
  }

  Future<void> _onPurchasePlan(PaymentPurchasePlan event, Emitter<PaymentState> emit) async {
    emit(const PaymentPurchaseReadyInProgress());

    final result = await _purchasePlanUsecase(
      userId: event.userId,
      productId: event.planId,
      offerCode: event.offerToken,
    );

    result.fold(
      (exception) => emit(PaymentPurchaseReadyFailure(exception: exception)),
      (plan) => emit(PaymentPurchaseReadySuccess(product: Product.fromId(event.planId))),
    );
  }
}
