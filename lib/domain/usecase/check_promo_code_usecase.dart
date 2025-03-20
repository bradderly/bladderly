// Package imports:
// Project imports:
import 'dart:async';

import 'package:bladderly/domain/model/promo_result.dart';
import 'package:bladderly/domain/repository/payment_repository.dart';
import 'package:bladderly/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CheckPromoCodeUsecase {
  const CheckPromoCodeUsecase({
    required PaymentRepository paymentRepository,
    required UserRepository userRepository,
  })  : _paymentRepository = paymentRepository,
        _userRepository = userRepository;

  final PaymentRepository _paymentRepository;
  final UserRepository _userRepository;

  Future<Either<Exception, PromoResult>> call({
    required String userId,
    required String code,
  }) async {
    try {
      final result = await _paymentRepository.checkPromo(
        userId: userId,
        code: code,
      );

      final localUserId = _userRepository.getLocalUserIdByUserId(userId);

      if (result case final MembershipPromoResult result when result.isValid && localUserId != null) {
        unawaited(
          Future<void>.sync(() async {
            final membership = await _userRepository.getMembershipFromServer(userId: userId);
            if (membership != null) _userRepository.saveMembership(localUserId: localUserId, membership: membership);
          }),
        );
      }

      return Right(result);
    } catch (e) {
      return Left(e is Exception ? e : Exception(e.toString()));
    }
  }
}
