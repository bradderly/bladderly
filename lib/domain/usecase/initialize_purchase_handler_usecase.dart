import 'dart:async';

import 'package:bladderly/domain/exception/purchase_failure_exception.dart';
import 'package:bladderly/domain/repository/payment_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@lazySingleton
class InitializePurchaseHandlerUsecase {
  InitializePurchaseHandlerUsecase({
    required InAppPurchase appPurchase,
    required PaymentRepository paymentRepository,
  })  : _inAppPurchase = appPurchase,
        _paymentRepository = paymentRepository;

  final InAppPurchase _inAppPurchase;
  final PaymentRepository _paymentRepository;
  final _purchaseStatusSubject = BehaviorSubject<PurchaseStatus?>();

  StreamSubscription<List<PurchaseDetails>>? _subscription;

  Either<Exception, Stream<PurchaseStatus?>> call({
    required String userId,
  }) {
    _purchaseStatusSubject.add(null);

    _subscription?.cancel();

    _subscription = _inAppPurchase.purchaseStream.listen(
      (list) => Future.wait(
        list.map(
          (purchaseDetails) => _onUpdatePurchaseStatus(
            userId: userId,
            purchaseDetails: purchaseDetails,
          ),
        ),
      ),
    );

    return Right(_purchaseStatusSubject);
  }

  Future<void> _onUpdatePurchaseStatus({
    required String userId,
    required PurchaseDetails purchaseDetails,
  }) async {
    final purchaseStatus = purchaseDetails.status;

    return switch (purchaseStatus) {
      PurchaseStatus.pending => _purchaseStatusSubject.add(purchaseStatus),
      PurchaseStatus.error =>
        _purchaseStatusSubject.addError(PurchaseFailureException(message: purchaseDetails.error!.message)),
      PurchaseStatus.canceled => _purchaseStatusSubject.add(purchaseStatus),
      PurchaseStatus.purchased => _onHandlePurchased(
          userId: userId,
          purchaseDetails: purchaseDetails,
        ),
      PurchaseStatus.restored => _onHandleRestored(
          userId: userId,
          purchaseDetails: purchaseDetails,
        ),
    };
  }

  Future<void> _onHandlePurchased({
    required String userId,
    required PurchaseDetails purchaseDetails,
  }) async {
    /// TODO(eden) : 구매 검증로직 필요
    //     await _paymentRepository.verifyPayment(
    //       userId: userId,
    //  receipt: purchaseDetails.productID,
    //     );

    _purchaseStatusSubject.add(purchaseDetails.status);

    if (purchaseDetails.pendingCompletePurchase) {
      await _inAppPurchase.completePurchase(purchaseDetails);
    }
  }

  Future<void> _onHandleRestored({
    required String userId,
    required PurchaseDetails purchaseDetails,
  }) async {
    /// TODO(eden) : 구매 검증로직 필요
    //     await _paymentRepository.verifyPayment(
    //       userId: userId,
    //  receipt: purchaseDetails.productID,
    //     );
    _purchaseStatusSubject.add(purchaseDetails.status);

    if (purchaseDetails.pendingCompletePurchase) {
      await _inAppPurchase.completePurchase(purchaseDetails);
    }
  }
}
