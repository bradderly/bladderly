import 'package:bladderly/domain/model/product.dart';
import 'package:bladderly/domain/repository/payment_repository.dart';
import 'package:bladderly/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PurchasePlanUsecase {
  const PurchasePlanUsecase({
    required PaymentRepository paymentRepository,
    required UserRepository userRepository,
  })  : _paymentRepository = paymentRepository,
        _userRepository = userRepository;

  final PaymentRepository _paymentRepository;
  final UserRepository _userRepository;

  Future<Either<Exception, void>> call({
    required String userId,
    required String productId,
  }) async {
    try {
      if (productId == Product.threeDaysPass.id) {
        // await _paymentRepository.purchaseWithoutIap(
        //   productId: productId,
        //   userId: userId,
        // );

        final membership = await _userRepository.getMembershipFromServer(userId: userId);

        _userRepository.saveMembership(
          localUserId: _userRepository.getLocalUserIdByUserId(userId)!,
          membership: membership!,
        );
      } else {
        await _paymentRepository.purchasePlan(productId: productId);
      }

      return const Right(null);
    } catch (e) {
      return Left(e is Exception ? e : Exception(e.toString()));
    }
  }
}
