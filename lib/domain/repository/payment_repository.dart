import 'package:bladderly/domain/model/plan.dart';

abstract class PaymentRepository {
  Future<List<Plan>> getPlans();

  Future<void> purchaseSubscriptionPlan({
    required String planId,
  });

  Future<void> purchaseOneTimePlan({
    required String userId,
    required String planId,
  });

  Future<void> verifyPayment({
    required String userId,
    required String productId,
    required String purchaseToken,
    required String receipt,
  });
}
