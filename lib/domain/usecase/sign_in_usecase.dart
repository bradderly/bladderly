// Package imports:

// Project imports:
import 'package:bladderly/domain/repository/auth_repository.dart';
import 'package:bladderly/domain/repository/history_repository.dart';
import 'package:bladderly/domain/repository/score_repository.dart';
// Package imports:
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SignInUsecase {
  const SignInUsecase({
    required AuthRepository authRepository,
    required HistoryRepository historyRepository,
    required ScoreRepository scoreRepository,
  })  : _authRepository = authRepository,
        _historyRepository = historyRepository,
        _scoreRepository = scoreRepository;

  final AuthRepository _authRepository;
  final HistoryRepository _historyRepository;
  final ScoreRepository _scoreRepository;

  Future<Either<Exception, void>> call({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _authRepository.signIn(email: email, password: password);

      await Future.wait([
        _historyRepository.getAllHistoriesFromServer(user.id).then(_historyRepository.saveHistories),
        _scoreRepository.getAllScoreHistoriesFromServer(user.id).then(_scoreRepository.saveScores),
      ]);

      return Right(user);
    } catch (e) {
      _authRepository.clearLocal();
      return Left(e is Exception ? e : Exception(e.toString()));
    }
  }
}
