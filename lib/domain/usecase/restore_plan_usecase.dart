import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RestorePlanUsecase {
  const RestorePlanUsecase({
    required InAppPurchase inAppPurchase,
  }) : _inAppPurchase = inAppPurchase;

  final InAppPurchase _inAppPurchase;

  Future<Either<Exception, void>> call() async {
    try {
      final result = await _inAppPurchase.restorePurchases();
      return Right(result);
    } catch (e) {
      return Left(e is Exception ? e : Exception(e.toString()));
    }
  }
}
