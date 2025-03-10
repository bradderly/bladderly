import 'package:bladderly/domain/repository/payment_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PurchasePlanUsecase {
  const PurchasePlanUsecase({
    required PaymentRepository paymentRepository,
  }) : _paymentRepository = paymentRepository;

  final PaymentRepository _paymentRepository;

  Future<Either<Exception, void>> call({
    required String planId,
  }) async {
    try {
      await _paymentRepository.purchaseSubscriptionPlan(planId: planId);
      return const Right(null);
    } catch (e) {
      return Left(e is Exception ? e : Exception(e.toString()));
    }
  }
}
