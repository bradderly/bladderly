// Package imports:

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:bladderly/domain/repository/auth_repository.dart';
import 'package:bladderly/domain/repository/history_repository.dart';

@lazySingleton
class SignInUsecase {
  const SignInUsecase({
    required AuthRepository authRepository,
    required HistoryRepository historyRepository,
  })  : _authRepository = authRepository,
        _historyRepository = historyRepository;

  final AuthRepository _authRepository;
  final HistoryRepository _historyRepository;

  Future<Either<Exception, void>> call({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _authRepository.signIn(email: email, password: password);
      final histories = await _historyRepository.getAllHistoriesFromServer(user.id);
      await _historyRepository.saveHistories(histories);

      return Right(user);
    } catch (e) {
      _authRepository.clearLocal();
      return Left(e is Exception ? e : Exception(e.toString()));
    }
  }
}
