import 'package:bladderly/domain/model/plan.dart';
import 'package:bladderly/domain/model/promo_result.dart';

abstract class PaymentRepository {
  Future<List<Plan>> getPlans();

  Future<bool> purchasePlan({
    required String productId,
  });

  Future<void> verifyPayment({
    required String userId,
    required String productId,
    required String purchaseToken,
    required String receipt,
  });

  Future<void> purchaseWithoutIap({
    required String userId,
    required String productId,
  });

  Future<PromoResult> checkPromo({
    required String userId,
    required String code,
  });
}
