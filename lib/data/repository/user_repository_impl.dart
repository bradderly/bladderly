import 'package:bladderly/data/api/client/api_client.dart';
import 'package:bladderly/data/api/model/swagger_json.models.swagger.dart';
import 'package:bladderly/data/isar/isar_client.dart';
import 'package:bladderly/data/mapper/user_mapper.dart';
import 'package:bladderly/domain/model/membership.dart';
import 'package:bladderly/domain/model/user.dart';
import 'package:bladderly/domain/repository/user_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl({
    required ApiClient apiClient,
    required IsarClient isarClient,
  })  : _apiClient = apiClient,
        _isarClient = isarClient;

  final ApiClient _apiClient;
  final IsarClient _isarClient;

  @override
  Future<String> changeName({required String userId, required String userName, String? userEmail}) async {
    final request = UpdateUserInfoRequest(
      id: userId,
      email: userEmail,
      username: userName,
    );

    final response = await _apiClient.updateUserName(request: request).then((response) => response.body!);

    return response.message ?? (throw Exception('Change Password failed'));
  }

  @override
  User? getUserOrNullByUserId(String userId) {
    final entity = _isarClient.getUserOrNullByUserId(userId);
    return entity == null ? null : UserMapper.fromUserEntity(entity);
  }

  @override
  User saveUser(User user) {
    final entity = _isarClient.saveUser(UserMapper.toUserEntity(user));

    return UserMapper.fromUserEntity(entity);
  }

  @override
  Stream<User?> get userStream =>
      _isarClient.userStream.map((entity) => entity == null ? null : UserMapper.fromUserEntity(entity));

  @override
  Future<Membership?> getMembership(String userId) {
    // TODO: implement getMembership
    throw UnimplementedError();
  }

  @override
  Membership saveMembership(Membership membership) {
    // TODO: implement saveMembership
    throw UnimplementedError();
  }
}
