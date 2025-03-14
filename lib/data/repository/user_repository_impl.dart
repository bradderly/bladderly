import 'dart:io';

import 'package:bladderly/data/api/client/api_client.dart';
import 'package:bladderly/data/api/model/swagger_json.models.swagger.dart';
import 'package:bladderly/data/isar/isar_client.dart';
import 'package:bladderly/data/mapper/membership_mapper.dart';
import 'package:bladderly/data/mapper/user_mapper.dart';
import 'package:bladderly/domain/exception/not_found_user_exception.dart';
import 'package:bladderly/domain/model/membership.dart';
import 'package:bladderly/domain/model/user.dart';
import 'package:bladderly/domain/repository/user_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({
    required ApiClient apiClient,
    required IsarClient isarClient,
  })  : _apiClient = apiClient,
        _isarClient = isarClient;

  final ApiClient _apiClient;
  final IsarClient _isarClient;

  @override
  Future<String> changeName({
    required String userId,
    required String userName,
    String? userEmail,
  }) async {
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
  Future<Membership?> getMembershipFromServer({
    required String userId,
  }) async {
    final response = await _apiClient
        .getPayInfo(userId: userId, device: Platform.isAndroid ? 'android' : 'ios')
        .then((response) => response.body!);

    return MembershipMapper.fromGetPayResponse(response);
  }

  @override
  Membership saveMembership({
    required int localUserId,
    required Membership membership,
  }) {
    final entity = MembershipMapper.toMembershipEntity(
      localUserId: localUserId,
      membership: membership,
    );

    return MembershipMapper.fromMembershipEntity(_isarClient.saveMembership(entity));
  }

  @override
  User migrateUser({required String userId, required User user}) {
    final userEntity = _isarClient.getUserOrNullByUserId(userId)
      ?..changeUserInfo(
        email: user.email,
        name: user.name,
        signUpMethod: user.signUpMethod.name,
        userId: user.userId,
      );

    if (userEntity == null) {
      throw const NotFoundUserException(message: 'not found user');
    }

    return UserMapper.fromUserEntity(_isarClient.saveUser(userEntity));
  }

  @override
  Stream<Membership?> getMembershipStream({required int localUserId}) => _isarClient
      .getMembershipStreamByUserId(localUserId)
      .map((entity) => entity == null ? null : MembershipMapper.fromMembershipEntity(entity));

  @override
  int? getLocalUserIdByUserId(String userId) {
    return _isarClient.getUserOrNullByUserId(userId)?.id;
  }
}
