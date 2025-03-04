// Package imports:
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:bladderly/domain/repository/auth_repository.dart';

@lazySingleton
class PlanCancelUsecase {
  const PlanCancelUsecase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  final AuthRepository _authRepository;

  Future<Either<Exception, String>> call({
    required String email,
    required String newPw,
    required String oldPw,
  }) async {
    try {
      final result = await _authRepository.changePassword(
        email: email,
        newPw: newPw,
        oldPw: oldPw,
      );
      return Right(result);
    } on Exception catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Exception('An unknown error occurred'));
    }
  }
}
