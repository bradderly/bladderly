import 'package:bladderly/domain/model/plan.dart';
import 'package:bladderly/domain/repository/payment_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetPaywallPlansUsecase {
  const GetPaywallPlansUsecase({
    required InAppPurchase inAppPurchase,
    required PaymentRepository paymentRepository,
  })  : _inAppPurchase = inAppPurchase,
        _paymentRepository = paymentRepository;

  final InAppPurchase _inAppPurchase;
  final PaymentRepository _paymentRepository;

  Future<Either<Exception, List<Plan>>> call() async {
    try {
      final isAailable = await _inAppPurchase.isAvailable();

      if (!isAailable) {
        throw Exception('In app purchase is not available');
      }

      final plans = await _paymentRepository.getPlans();

      return Right(plans);
    } catch (e) {
      return Left(e is Exception ? e : Exception(e.toString()));
    }
  }
}
