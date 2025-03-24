// Package imports:

// Project imports:
import 'package:bladderly/core/event_analyzer/event_analyzer.dart';
import 'package:bladderly/domain/repository/auth_repository.dart';
// Package imports:
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SignOutUsecase {
  const SignOutUsecase({required AuthRepository authRepository, required EventAnalyzer eventAnalyzer})
      : _authRepository = authRepository,
        _eventAnalyzer = eventAnalyzer;

  final AuthRepository _authRepository;
  final EventAnalyzer _eventAnalyzer;

  Either<Exception, void> call({
    required String userId,
  }) {
    try {
      _authRepository.signOut(userId).onError((_, __) {});
      _eventAnalyzer.clearUser();
      _authRepository.clearLocal();
      return const Right(null);
    } on Exception catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
