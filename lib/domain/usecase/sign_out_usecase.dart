// Package imports:

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:bladderly/domain/repository/auth_repository.dart';

@lazySingleton
class SignOutUsecase {
  const SignOutUsecase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  final AuthRepository _authRepository;

  Either<Exception, void> call({required String userId}) {
    try {
      _authRepository.signOut(userId).onError((_, __) {});
      _authRepository.clearLocal();
      return const Right(null);
    } on Exception catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
