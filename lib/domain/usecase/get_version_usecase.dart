// Package imports:
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:bladderly/data/api/model/swagger_json.models.swagger.dart';
import 'package:bladderly/domain/repository/auth_repository.dart';

@lazySingleton
class GetVersionUsecase {
  const GetVersionUsecase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  final AuthRepository _authRepository;

  Future<Either<Exception, GetVersionResponse>> call({
    required String device,
  }) async {
    try {
      final result = await _authRepository.getVersion(
        device: device,
      );
      return Right(result);
    } on Exception catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Exception('An unknown error occurred'));
    }
  }
}
