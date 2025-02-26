import 'package:bradderly/data/api/client/api_client.dart';
import 'package:bradderly/data/api/model/swagger_json.models.swagger.dart';
import 'package:bradderly/data/isar/isar_client.dart';
import 'package:bradderly/data/mapper/user_mapper.dart';
import 'package:bradderly/domain/model/sex.dart';
import 'package:bradderly/domain/model/user.dart';
import 'package:bradderly/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required IsarClient isarClient,
    required ApiClient apiClient,
  })  : _isarClient = isarClient,
        _apiClient = apiClient;

  final IsarClient _isarClient;
  final ApiClient _apiClient;

  @override
  Future<bool> checkExistingUser({required String email}) {
    throw UnimplementedError();
  }

  @override
  Future<User> signin({required String email, required String password}) {
    throw UnimplementedError();
  }

  @override
  Future<User> signup({required String userId, required String email, required String password}) {
    throw UnimplementedError();
  }

  @override
  Future<User> signupGuest({
    required String userId,
    required Gender gender,
    required int yearOfBirth,
    required String region,
    required String device,
  }) async {
    await _apiClient.signUp(
      request: SignUpRequest(
        guestId: userId,
        gender: gender.name,
        birthyear: '$yearOfBirth',
        device: device,
        region: region,
        social: 'N',
      ),
    );

    return User(
      id: userId,
      email: null,
      name: null,
      gender: gender.name,
      yearOfBirth: yearOfBirth,
      signupMethod: 'N',
    );
  }

  @override
  Stream<User> get userStream => _isarClient.getUserStream().map(UserMapper.fromUserEntity);
}
